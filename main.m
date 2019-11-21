clear; clc;
% Parâmetros
path = '/home/ileon/Documentos/Codificacao/YUVSequences/A2/CatRobot_3840x2160_60fps_10bit_420.yuv';
width = 3840;
height = 2160;
bitDepth = 10;
nFrames = 1;

% Formato de cada linha no arquivo CSV
fid = fopen("format.txt", "r");
format = fgets(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName2.txt","r");
columnsName = fgetl(fid);
fclose(fid);

% Block sizes
bs = [128, 64, 32, 16, 8, 4];
% Inicializa os arquivos CSV
fids = [0, 0, 0, 0, 0, 0];
videoName = split(path,"/");
videoName = split(char(videoName(8)),".");
videoName = char(videoName(1));
fileName = videoName;
for i=1:6
    fids(i)=fopen(strcat(videoName,"_",num2str(bs(i)),"x",num2str(bs(i)),".csv"),"w");
    fprintf(fids(i),"%s",columnsName);
end

% Abre o arquivo do vídeo e realiza os cálculos para cada frame a para cada
% tamanho de bloco
fidVideo = fopen(path,"r");
tic
for i=1:nFrames
    disp(strcat("Frame ", num2str(i), " de ", num2str(nFrames)));
    [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
    for j=1:6
        disp(strcat("Gerando blocos de tamanho ", num2str(bs(j)),"x",num2str(bs(j))));
        bY = blocks(y, width, height, bs(j), bs(j));
        [~, ~, nBlocks] = size(bY);
        disp("Calculando os operadores para cada bloco");
        for k=1:nBlocks
            block = bY(:,:,k);
            s = sobel(block);
            r = roberts(block);
            p = prewitt(block);
            m = media(block);
            e = desvio_variancia(block, bs(j), bs(j));
            blockm = medfilt2(block); %Bloco após filtro mediana
            blockh = histeq(block); %Bloco após equalização de histograma
            sm = sobel(blockm);
            rm = roberts(blockm);
            pm = prewitt(blockm);
            mm = media(blockm);
            em = desvio_variancia(blockm, bs(j), bs(j));
            sh = sobel(blockh);
            rh = roberts(blockh);
            ph = prewitt(blockh);
            mh = media(blockh);
            eh = desvio_variancia(blockh, bs(j), bs(j));
            fprintf(fids(j), format, mat2str(block),s, r, p, m, e,sm, rm, pm, mm, em,sh, rh, ph, mh, eh);
        end
    end
end
toc
disp("Fechando arquivos");
for i=1:6
    fclose(fids(i));
end
fclose(fidVideo);
disp("Fim");

% % Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(uint8(0.25*bY(:,:, i)));
% end