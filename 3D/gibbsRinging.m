function imageVolume = gibbsRinging(imageVolume, numSample, p)

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

% Random Gibbs ringing (oscillation) artefact generation in 3D images

% imageVolume: 3D image volume
% numSample: cutting/truncation k-space frequency
% p: performed artefact dimension/plane

% Simulating Gibbs ringing artefact
[imageHeight, imageWidth, imageDepth] = size(imageVolume); % volume size
if p == 1 % along x-axis
    imageVolume = permute(imageVolume, [1, 3, 2]); % [Height, Depth, Width]
    imageVolume = fftshift(fftn(imageVolume, [imageHeight, imageDepth, imageWidth])); % centralized fast Fourier transform (k-space)
    imageVolume(:, :, [1 : ceil(imageWidth / 2) - ceil(numSample / 2), ceil(imageWidth / 2) + ceil(numSample / 2) : imageWidth]) = 0; % truncated high frequency components
    imageVolume = abs(ifftn(ifftshift(imageVolume), [imageHeight, imageDepth, imageWidth])); % inverse fft of decentralized truncated data
    imageVolume = permute(imageVolume, [1, 3, 2]); % [Height, Width, Depth]
elseif p == 2 % along y-axis
    imageVolume = permute(imageVolume, [2, 3, 1]); % [Width, Depth, Height]
    imageVolume = fftshift(fftn(imageVolume, [imageWidth, imageDepth, imageHeight])); % centralized fast Fourier transform (k-space)
    imageVolume(:, :, [1 : ceil(imageHeight / 2) - ceil(numSample / 2), ceil(imageHeight / 2) + ceil(numSample / 2) : imageHeight]) = 0; % truncated frequency components
    imageVolume = abs(ifftn(ifftshift(imageVolume), [imageWidth, imageDepth, imageHeight])); % inverse fft of decentralized truncated data
    imageVolume = permute(imageVolume, [3, 1, 2]); % [Height, Width, Depth]
elseif p == 3 % along z-axis
    imageVolume = fftshift(fftn(imageVolume, [imageHeight, imageWidth, imageDepth])); % centralized fast Fourier transform (k-space)
    imageVolume(:, :, [1 : ceil(imageDepth / 2) - ceil(numSample / 2), ceil(imageDepth / 2) + ceil(numSample / 2) : imageDepth]) = 0; % truncated frequency components
    imageVolume = abs(ifftn(ifftshift(imageVolume), [imageHeight, imageWidth, imageDepth])); % inverse fft of decentralized truncated data
end

end
