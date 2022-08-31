
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

% Plausible noisy MRI simulation for data augmentation

restoredefaultpath
close all
clear
clc

%% Original Image

load mri; % load the MRI sample
X = squeeze(D); % input 3D MRI volume

figure, montage(X, map, 'Indices', [1 : 12]); % original image slices
title('Horizontal Slices of the Original Image');

%% Elastic Deformation

sigma = (20 - 10) * rand + 10; % elasticity coefficient randomly chosen in [10 20]
alpha = (200 - 100) * rand + 100; % scaling factor randomly chosen in [100 200]
interMethod = 'nearest'; % interpolation method
extraMethod = 'nearest'; % extrapolation method

Y1 = elasticDeform(X, sigma, alpha, interMethod, extraMethod); % image deformation

figure, montage(uint8(Y1), map, 'Indices', [1 : 12]); % deformed image slices
title('Horizontal Slices of the Deformed Image');

%% Intensity Inhomogeneity

Y2 = biasField(X); % biased image

figure, montage(uint8(Y2), map, 'Indices', [1 : 12]); % biased image slices
title('Horizontal Slices of the Inhomogeneous Image');

%% Gibbs Ringing

cutFreq = randi([64, 96]); % cutting k-space frequency
dim = 1; % performed artefact dimension

Y3 = gibbsRinging(X, cutFreq, dim); % image truncation

figure, montage(uint8(Y3), map, 'Indices', [1 : 12]); % truncated image slices
title('Horizontal Slices of the Oscillating Image');

%% Motion Ghosting

alpha = (0.7 - 0.5) * rand + 0.5; % intensity factor randomly chosen in [0.5 0.7]
numReps = randi([2, 4]); % number of ghosts
dim = 2; % performed artefact dimension

Y4 = motionGhosting(X, alpha, numReps, dim); % image repetition

figure, montage(uint8(Y4), map, 'Indices', [1 : 12]); % repeated image slices
title('Horizontal Slices of the Ghosted Image');

%% Additive Noise

sigma = 1e-4 * rand; % variance of Gaussian noise

Y5 = imnoise(X, 'gaussian', 0, sigma); % zero-mean Gaussian noise addition

figure, montage(Y5, map, 'Indices', [1 : 12]); % noisy image slices
title('Horizontal Slices of the Additive Noisy Image');

%% Multiplicative Noise

sigma = 1e-4 * rand; % variance of multiplicative noise

Y6 = imnoise(X, 'speckle', sigma); % zero-mean noise multiplication

figure, montage(Y6, map, 'Indices', [1 : 12]); % noisy image slices
title('Horizontal Slices of the Multiplicative Noisy Image');

%% Rotation

r = [0, 0, 1]; % rotation axis
theta = randi([-10, 10]); % rotation angle
interMethod = 'nearest'; % interpolation method such as 'linear', 'cubic', 'spline', 'nearest'
fillingValue = 0; % values for filling pixels outside the input image such as 0 or 'Background'

if iscategorical(X)
    Y7 = imrotate3(X, theta, r, 'nearest', 'crop', 'FillValues', fillingValue); % categorical volume rotation about the axis
else
    Y7 = imrotate3(X, theta, r, interMethod, 'crop', 'FillValues', fillingValue); % volume rotation about the axis
end

figure, montage(Y7, map, 'Indices', [1 : 12]); % rotated image slices
title('Horizontal Slices of the Rotated Image');
