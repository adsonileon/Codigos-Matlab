clear; clc;
path = 'Johnny_1280x720_60.yuv';
width = 1280;
height = 720;
nFrames = 1;
blockSizeW = 64;
blockSizeH = 64;
components = 1;
[bY, ~, ~] = readVideo(path, width, height, nFrames, blockSizeW, blockSizeH, components);
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(bY(:,:, i,1));
% end
block = bY(:,:,110,1);
[sobelV, sobelH, sobelMagVH, sobelDirVH, sobelUR, sobelUL, sobelMagD, sobelDirD] = sobel(block);
%[robertsUR, robertsUL, robertsMagD, robertsDirD] = roberts(block);
%[prewittV, prewittH, prewittMagVH, prewittDirVH, prewittUR, prewittUL, prewittMagD, prewittDirD] = prewitt(block);
%m = media(block);
%[dH, dV, dUR, dUL, vH, vV, vUR, vUL] = desvio_variancia(block, blockSizeW, blockSizeH);