function imageSlice = biasField(imageSlice)

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

% Random intensity inhomogeneity generation in 2D images

% imageSlice: 2D image

% Generating a gradient field with intensity inhomogeneity
[imageHeight, imageWidth] = size(imageSlice); % slice size
[X, Y] = ndgrid(1 : imageHeight, 1 : imageWidth); % structured rectangular grid
x0 = randi([1, imageHeight]); % random x-center
y0 = randi([1, imageWidth]); % random y-center
G = 1 - ((X - x0) .^ 2 / (imageHeight ^ 2) + (Y - y0) .^ 2 / (imageWidth ^ 2)); % elliptic gradient field

% Slice modification using the multiplicative inhomogeneity model
imageSlice = G .* double(imageSlice);

end