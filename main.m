clear; clc;
path = 'Johnny_1280x720_60.yuv';
width = 1280;
height = 720;
nFrames = 1;
blockSizeW = 64;
blockSizeH = 64;
components = 1;
%1 e 2 dimensão: tamanhos do bloco 3 dimensão: numero do bloco 4 dimensão:
%numero do frame
[bY, ~, ~] = readVideo(path, width, height, nFrames, blockSizeW, blockSizeH, components);
[~, ~, nBlocks, ~] = size(bY);
columnsS = ["Gv Sobel","Gh Sobel","Mag1 Sobel","Dir1 Sobel","Gur Sobel","Gul Sobel","Mag2 Sobel","Dir2 Sobel"];
columnsR = ["Gul Roberts","Gur Roberts","Mag Roberts","Dir Roberts"];
columnsP = ["Gv Prewitt","Gh Prewitt","Mag1 Prewitt","Dir1 Prewitt","Gur Prewitt","Gul Prewitt","Mag2 Prewitt","Dir2 Prewitt"];
columnsM = "Media";
columnsE = ["Desvio h","Desvio v","Desvio ur","Desvio ul","Variancia h","Variancia v","Variancia ur","Variancia ul"];
format1 = "%s,";
format2 = "%s,";
for i=1:29
    if i~=29
        format1 = strcat(format1, "%s,");
        format2 = strcat(format2, "%f,");
    else
        format1 = strcat(format1, "%s\n");
        format2 = strcat(format2, "%f\n");
    end
end
fid = fopen("teste.csv", "w");
fprintf(fid, format1, "Bloco",columnsS, columnsR, columnsP, columnsM, columnsE);
for i = 1:nFrames
    for j=1:nBlocks
        s = sobel(bY(:,:,j,i));
        r = roberts(bY(:,:,j,i));
        p = prewitt(bY(:,:,j,i));
        m = media(bY(:,:,j,i));
        e = desvio_variancia(bY(:,:,j,i), blockSizeW, blockSizeH);
        fprintf(fid, format2, "b1",s, r, p, m, e);
    end
end
fclose(fid);
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(bY(:,:, i,1));
% end
