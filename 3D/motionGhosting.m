function imageVolume = motionGhosting(imageVolume, alpha, numReps, p)

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

% Random motion ghosting artefact generation in 3D images

% imageVolume: 3D image volume
% alpha: intensity factor of the deformation
% numReps: number of repetitions (duplications/ghosts)
% p: performed artefact dimension/plane

% Simulating motion ghosting artefact
[imageHeight, imageWidth, imageDepth] = size(imageVolume); % volume size
imageVolume = fftn(imageVolume, [imageHeight, imageWidth, imageDepth]); % fast Fourier transform (k-space)
if p == 1 % along y-axis
    imageVolume(1 : numReps : end, :, :) = alpha * imageVolume(1 : numReps : end, :, :); % k-space lines are modulated differently
elseif p == 2 % along x-axis
    imageVolume(:, 1 : numReps : end, :) = alpha * imageVolume(:, 1 : numReps : end, :); % k-space lines are modulated differently
elseif p == 3 % along z-axis
    imageVolume(:, :, 1 : numReps : end) = alpha * imageVolume(:, :, 1 : numReps : end); % k-space lines are modulated differently
end
imageVolume = abs(ifftn(imageVolume, [imageHeight, imageWidth, imageDepth])); % inverse ifft of modified data

end
