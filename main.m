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
format = "%s,";
for i=1:87
    if i~=87
        format = strcat(format, "%f,");
    else
        format = strcat(format, "%f\n");
    end
end
fid1 = fopen("teste.csv", "w");
fid2 = fopen("columnsName.txt","r");
line = fgetl(fid2);
while ischar(line)
    fprintf(fid1, "%s", line);
    line = fgetl(fid2);
    if ischar(line)
        fprintf(fid1, ",");
    else
        fprintf(fid1, "\n");
    end
end
fclose(fid2);
for i = 1:nFrames
    for j=1:nBlocks
        block = bY(:,:,j,i);
        s = sobel(block);
        r = roberts(block);
        p = prewitt(block);
        m = media(block);
        e = desvio_variancia(block, blockSizeW, blockSizeH);
        blockm = medfilt2(block); %Bloco após filtro mediana
        blockh = histeq(block); %Bloco após equalização de histograma
        sm = sobel(blockm);
        rm = roberts(blockm);
        pm = prewitt(blockm);
        mm = media(blockm);
        em = desvio_variancia(blockm, blockSizeW, blockSizeH);
        sh = sobel(blockh);
        rh = roberts(blockh);
        ph = prewitt(blockh);
        mh = media(blockh);
        eh = desvio_variancia(blockh, blockSizeW, blockSizeH);
        fprintf(fid1, format, "b1",s, r, p, m, e,sm, rm, pm, mm, em,sh, rh, ph, mh, eh);
    end
end
fclose(fid1);

% Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(bY(:,:, i,1));
% end