clear;clc;
% Parâmetros
path = 'D:\Codificacao\YUVSequences\D\BQSquare_416x240_60fps_8bit_420.yuv';
width = 416;
height = 240;
bitDepth = 8;
bytes = 1.5*width*height;
fidVideo = fopen(path,"r");
[y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
% fseek(fidVideo,7*bytes,0);
% [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
% y = uint8(0.25*y);
%yh = histeq(y);
% ym = imadjust(y);
% subplot(1,2,1);
% imshow(y);
% yh1 = y - yh;
% yh2 = y + yh1;
% subplot(1,2,2);
% imshow(ym);
% subplot(1,4,3);
% imshow(yh1);
% subplot(1,4,4);
% imshow(yh2);
% imshow(yh2);
bY = blocks(y, width, height, 64, 64);
block = bY(:,:,1);
s = sobel(block);
r = roberts(block);
m = media(block);
p = prewitt(block);
e = desvio_variancia(block);
% subplot(1,2,1);
% imshow(block);
% h = histeq(block);
% blockh = h - block;
% subplot(1,2,2);
% imshow(blockh);
fclose(fidVideo);
% bw = 16;
% bh = 4;
% for i=-bh+1:bw-1
%     [urIndI, urIndJ] = digitalLine(1, i, bw, bw);
%     disp(num2str(i));
%     for j=1:size(urIndI)
%         if urIndI(j) <= bh && urIndJ(j) <= bw
%             disp(strcat(num2str(urIndI(j)), ",", num2str(urIndJ(j))));
%         end
%     end
%     disp(" ");
% end