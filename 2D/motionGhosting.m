function imageSlice = motionGhosting(imageSlice, alpha, numReps, p)

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

% Random motion ghosting artefact generation in 2D images

% imageSlice: 2D image
% alpha: intensity factor of the deformation
% numReps: number of repetitions (duplications/ghosts)
% p: performed artefact dimension/plane

% Simulating motion ghosting artefact
[imageHeight, imageWidth] = size(imageSlice); % slice size
imageSlice = fftn(imageSlice, [imageHeight, imageWidth]); % fast Fourier transform (k-space)
if p == 1 % along y-axis
    imageSlice(1 : numReps : end, :) = alpha * imageSlice(1 : numReps : end, :); % k-space lines are modulated differently
elseif p == 2 % along x-axis
    imageSlice(:, 1 : numReps : end) = alpha * imageSlice(:, 1 : numReps : end); % k-space lines are modulated differently
end
imageSlice = abs(ifftn(imageSlice, [imageHeight, imageWidth])); % inverse ifft of modified data

end
