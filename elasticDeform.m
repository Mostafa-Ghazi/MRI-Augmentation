function imageVolume = elasticDeform(imageVolume, sigma, alpha, interMethod, extraMethod)

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
%%%%%                https://arxiv.org/abs/XXXX.YYYYY                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Elastic deformation of 3D images using random displacement fields

% imageVolume: 3D image or label volume
% sigma: elasticity coefficient for smoothing the random field
% alpha: scaling factor controlling the intensity of the deformation
% interMethod: interpolation method such as 'linear', 'cubic', 'spline', 'nearest'
% extraMethod: extrapolation method such as 'linear', 'cubic', 'spline', 'nearest'

% Generating a random displacement field
[imageHeight, imageWidth, imageDepth] = size(imageVolume); % volume size
dx = 2 * rand(imageHeight, imageWidth, imageDepth) - 1; % ~U(-1, 1)
dy = 2 * rand(imageHeight, imageWidth, imageDepth) - 1; % ~U(-1, 1)
dz = 2 * rand(imageHeight, imageWidth, imageDepth) - 1; % ~U(-1, 1)

% Smoothing and scaling the field
kernelSize = 2 * ceil(2 * sigma) + 1; % square kernel size
dx = alpha * imgaussfilt3(dx, sigma, 'FilterSize', kernelSize, 'Padding', 'replicate', 'FilterDomain', 'spatial'); % filtered and scaled
dy = alpha * imgaussfilt3(dy, sigma, 'FilterSize', kernelSize, 'Padding', 'replicate', 'FilterDomain', 'spatial'); % filtered and scaled
dz = alpha * imgaussfilt3(dz, sigma, 'FilterSize', kernelSize, 'Padding', 'replicate', 'FilterDomain', 'spatial'); % filtered and scaled

% Applying the random displacement (elastic distortion) to the pixels
[x, y, z] = ndgrid(1 : imageHeight, 1 : imageWidth, 1 : imageDepth); % structured rectangular grid
if iscategorical(imageVolume)
    [uniqueLabels, ~, numericLabels] = unique(imageVolume, 'stable'); % categorical to numerical data conversion
    numericLabels = reshape(numericLabels, [imageHeight, imageWidth, imageDepth]); % numerical data
    F = griddedInterpolant(x, y, z, numericLabels, 'nearest', 'nearest'); % gridded data interpolation
    imageVolume = uniqueLabels(F(x + dx, y + dy, z + dz)); % interpolant function evaluation at query points and conversion to categorical
else
    F = griddedInterpolant(x, y, z, double(imageVolume), interMethod, extraMethod); % gridded data interpolation
    imageVolume = F(x + dx, y + dy, z + dz); % interpolant function evaluation at query points
end

end