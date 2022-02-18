function imageSlice = gibbsRinging(imageSlice, numSample, p)

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

% Random Gibbs ringing (oscillation) artefact generation in 2D images

% imageSlice: 2D image
% numSample: cutting/truncation k-space frequency
% p: performed artefact dimension/plane

% Simulating Gibbs ringing artefact
[imageHeight, imageWidth] = size(imageSlice); % slice size
if p == 1 % along x-axis
    imageSlice = fftshift(fftn(imageSlice, [imageHeight, imageWidth])); % centralized fast Fourier transform (k-space)
    imageSlice(:, [1 : ceil(imageWidth / 2) - ceil(numSample / 2), ceil(imageWidth / 2) + ceil(numSample / 2) : imageWidth]) = 0; % truncated high frequency components
    imageSlice = abs(ifftn(ifftshift(imageSlice), [imageHeight, imageWidth])); % inverse fft of decentralized truncated data
elseif p == 2 % along y-axis
    imageSlice = fftshift(fftn(imageSlice', [imageWidth, imageHeight])); % centralized fast Fourier transform (k-space)
    imageSlice(:, [1 : ceil(imageHeight / 2) - ceil(numSample / 2), ceil(imageHeight / 2) + ceil(numSample / 2) : imageHeight]) = 0; % truncated frequency components
    imageSlice = abs(ifftn(ifftshift(imageSlice), [imageWidth, imageHeight]))'; % inverse fft of decentralized truncated data
end

end