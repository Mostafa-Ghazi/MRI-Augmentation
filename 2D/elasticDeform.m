function imageSlice = elasticDeform(imageSlice, sigma, alpha, interMethod, extraMethod)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                 Source Code Author Information                  %%%%%
%%%%%                     Mostafa Mehdipour Ghazi                     %%%%%
%%%%%                   mostafa.mehdipour@gmail.com                   %%%%%
%%%%%                      Created on 01/01/2021                      %%%%%
%%%%%                      Updated on 01/01/2022                      %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  This code is an implementation of the algorithm published in:  %%%%%
%%%%%                          FAST-AID Brain                         %%%%%
%%%%%                https://arxiv.org/abs/2208.14360                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Elastic deformation of 2D images using random displacement fields

% imageSlice: 2D image or label slice
% sigma: elasticity coefficient for smoothing the random field
% alpha: scaling factor controlling the intensity of the deformation
% interMethod: interpolation method such as 'linear', 'cubic', 'spline', 'nearest'
% extraMethod: extrapolation method such as 'linear', 'cubic', 'spline', 'nearest'

% Generating a random displacement field
[imageHeight, imageWidth] = size(imageSlice); % slice size
dx = 2 * rand(imageHeight, imageWidth) - 1; % ~U(-1, 1)
dy = 2 * rand(imageHeight, imageWidth) - 1; % ~U(-1, 1)

% Smoothing and scaling the field
kernelSize = 2 * ceil(2 * sigma) + 1; % square kernel size
dx = alpha * imgaussfilt(dx, sigma, 'FilterSize', kernelSize, 'Padding', 'replicate', 'FilterDomain', 'spatial'); % filtered and scaled
dy = alpha * imgaussfilt(dy, sigma, 'FilterSize', kernelSize, 'Padding', 'replicate', 'FilterDomain', 'spatial'); % filtered and scaled

% Applying the random displacement (elastic distortion) to the pixels
[x, y] = ndgrid(1 : imageHeight, 1 : imageWidth); % structured rectangular grid
if iscategorical(imageSlice)
    [uniqueLabels, ~, numericLabels] = unique(imageSlice, 'stable'); % categorical to numerical data conversion
    numericLabels = reshape(numericLabels, [imageHeight, imageWidth]); % numerical data
    F = griddedInterpolant(x, y, numericLabels, 'nearest', 'nearest'); % gridded data interpolation
    imageSlice = uniqueLabels(F(x + dx, y + dy)); % interpolant function evaluation at query points and conversion to categorical
else
    F = griddedInterpolant(x, y, double(imageSlice), interMethod, extraMethod); % gridded data interpolation
    imageSlice = F(x + dx, y + dy); % interpolant function evaluation at query points
end

end
