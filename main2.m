clear;clc;
% Parâmetros
path = 'D:\Codificacao\YUVSequences\C\RaceHorses_832x480_30fps_8bit_420.yuv';
width = 832;
height = 480;
bitDepth = 8;
%bytes = 3*width*height;
fidVideo = fopen(path,"r");
[y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
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
bY = blocks(y, width, height, 4, 8);
block = bY(:,:,1);
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