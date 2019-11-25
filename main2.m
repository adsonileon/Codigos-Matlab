clear;clc;
% % Parâmetros
% path = '/home/ileon/Documentos/Codificacao/YUVSequences/B/MarketPlace_1920x1080_60fps_10bit_420.yuv';
% width = 1920;
% height = 1080;
% bitDepth = 10;
% bytes = 3*width*height;
% 
% skip = 4;
% fidVideo = fopen(path,"r");
% for i=1:skip:600
%     [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
%     fseek(fidVideo, (skip-1)*bytes,0);
% end
% imshow(uint8(0.25*y));
% subplot(1,2,1);
% imshow(uint8(0.25*y));
% fseek(fidVideo,bytes,0);
% [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
% subplot(1,2,2);
% imshow(uint8(0.25*y));
% fclose(fidVideo);
blockSizeH = 4;
blockSizeW = 2;
[urIndI, urIndJ] = digitalLine(1, 1, 4, 4);