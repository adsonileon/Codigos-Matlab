clear;clc;
% Parâmetros
path = '/home/ileon/Documentos/Codificacao/YUVSequences/B/BasketballDrive_1920x1080_50fps_8bit_420.yuv';
width = 1920;
height = 1080;
bitDepth = 8;
skip = 50;
fidVideo = fopen(path,"r");
[y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
subplot(1,2,1);
imshow(uint8(0.25*y));
bytes = 1.5*width*height*skip;
fseek(fidVideo,bytes,0);
[y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
subplot(1,2,2);
imshow(uint8(0.25*y));
fclose(fidVideo);
