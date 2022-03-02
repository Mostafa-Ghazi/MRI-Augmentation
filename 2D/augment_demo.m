
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

% Plausible noisy MRI simulation for data augmentation

restoredefaultpath
close all
clear
clc

%% Original Image

load mri; % load the MRI sample
X = squeeze(D); % input 3D MRI volume
X12 = X(:, :, 12); % a sample slice

figure, imshow(uint8(X12)); % original image slice
title('Original Image Slice');

%% Elastic Deformation

sigma = (20 - 10) * rand + 10; % elasticity coefficient randomly chosen in [10 20]
alpha = (200 - 100) * rand + 100; % scaling factor randomly chosen in [100 200]
interMethod = 'nearest'; % interpolation method
extraMethod = 'nearest'; % extrapolation method

Y1 = elasticDeform(X12, sigma, alpha, interMethod, extraMethod); % image deformation

figure, imshow(uint8(Y1)); % deformed image slice
title('Deformed Image Slice');

%% Intensity Inhomogeneity

Y2 = biasField(X12); % biased image

figure, imshow(uint8(Y2)); % biased image slice
title('Inhomogeneous Image Slice');

%% Gibbs Ringing

cutFreq = randi([64, 96]); % cutting k-space frequency
dim = 1; % performed artefact dimension

Y3 = gibbsRinging(X12, cutFreq, dim); % image truncation

figure, imshow(uint8(Y3)); % truncated image slice
title('Oscillating Image Slice');

%% Motion Ghosting

alpha = (0.7 - 0.5) * rand + 0.5; % intensity factor randomly chosen in [0.5 0.7]
numReps = randi([2, 4]); % number of ghosts
dim = 2; % performed artefact dimension

Y4 = motionGhosting(X12, alpha, numReps, dim); % image repetition

figure, imshow(uint8(Y4)); % repeated image slice
title('Ghosted Image Slice');

%% Additive Noise

sigma = 1e-4 * rand; % variance of Gaussian noise

Y5 = imnoise(X12, 'gaussian', 0, sigma); % zero-mean Gaussian noise addition

figure, imshow(Y5); % noisy image slice
title('Additive Noisy Image Slice');

%% Multiplicative Noise

sigma = 1e-4 * rand; % variance of multiplicative noise

Y6 = imnoise(X12, 'speckle', sigma); % zero-mean noise multiplication

figure, imshow(Y6); % noisy image slice
title('Multiplicative Noisy Image Slice');

%% Rotation

theta = randi([-10, 10]); % rotation angle
interMethod = 'nearest'; % interpolation method such as 'linear', 'cubic', 'spline', 'nearest'

if iscategorical(X12)
    Y7 = imrotate(X12, theta, 'nearest', 'crop'); % categorical slice rotation
else
    Y7 = imrotate(X12, theta, interMethod, 'crop'); % image slice rotation
end

figure, imshow(Y7); % rotated image slice
title('Rotated Image Slice');

%% Flip/Mirror

dim = 1; % performed mirroring dimension

if dim == 1
    Y8 = flipud(X12); % categorical slice rotation
elseif dim == 2
    Y8 = fliplr(X12); % image slice rotation
end

figure, imshow(Y8); % flipped image slice
title('Flipped Image Slice');

%% Blurring

timeRatio = 3; % ratio of the total k-space time to T2* time
dim = 2; % performed artefact dimension

Y9 = blurring(X12, timeRatio, dim); % image blurring

figure, imshow(uint8(Y9)); % blurred image slice
title('Blurred Image Slice');
