clear;clc;
% Parâmetros
% path = '/home/ileon/Documentos/Codificacao/YUVSequences/D/BQSquare_416x240_60fps_8bit_420.yuv';
% width = 416;
% height = 240;
% bitDepth = 8;
% fidVideo = fopen(path,"r");
% [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
% bY = blocks(y, width, height, 4, 4);
% block = bY(:,:,106);
% fclose(fidVideo);
for i=-6:6
    [urIndI, urIndJ] = digitalLine(1, i, 7, 7);
    disp(strcat("Offset ", num2str(i)));
    for j=1:size(urIndI)
        disp(strcat(num2str(urIndI(j)),",",num2str(urIndJ(j))));
    end
    disp("end");
end