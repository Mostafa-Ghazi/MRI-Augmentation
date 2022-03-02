function imageSlice = blurring(imageSlice, timeRatio, p)

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

% Random blurring artefact generation in 2D images

% imageSlice: 2D image
% timeRatio: ratio of the total k-space time (ms) to T2* time (ms)
% p: performed artefact dimension/plane

% Simulating blurring artefact
[imageHeight, imageWidth] = size(imageSlice); % slice size
imageSlice = fftn(imageSlice, [imageHeight, imageWidth]); % fast Fourier transform (k-space)
if p == 1 % along y-axis
    timeGrid = linspace(0, timeRatio, imageHeight)'; % linearly spaced vector
    timeGrid = exp(-timeGrid); % exponential time decay
    timeGrid = repmat(timeGrid, [1, imageWidth]); % column-wise repeatd array
elseif p == 2 % along x-axis
    timeGrid = linspace(0, timeRatio, imageWidth); % linearly spaced vector
    timeGrid = exp(-timeGrid); % exponential time decay
    timeGrid = repmat(timeGrid, [imageHeight, 1]); % row-wise repeatd array
end
imageSlice = imageSlice .* timeGrid; % pixels are modified differently
imageSlice = abs(ifftn(imageSlice, [imageHeight, imageWidth])); % inverse ifft of modified data

end