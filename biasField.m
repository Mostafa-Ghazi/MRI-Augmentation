function imageVolume = biasField(imageVolume)

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

% Random intensity inhomogeneity generation in 3D images

% imageVolume: 3D image or label volume

% Generating a gradient field with intensity inhomogeneity
[imageHeight, imageWidth, imageDepth] = size(imageVolume); % volume size
[X, Y, Z] = ndgrid(1 : imageHeight, 1 : imageWidth, 1 : imageDepth); % structured rectangular grid
x0 = randi([1, imageHeight]); % random x-center
y0 = randi([1, imageWidth]); % random y-center
z0 = randi([1, imageDepth]); % random z-center
G = 1 - ((X - x0) .^ 2 / (imageHeight ^ 2) + (Y - y0) .^ 2 / (imageWidth ^ 2) + (Z - z0) .^ 2 / (imageDepth ^ 2)); % elliptic gradient field

% Volume modification using the multiplicative inhomogeneity model
imageVolume = G .* double(imageVolume);

end