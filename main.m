clear; clc;
% Parâmetros
path = '/home/ileon/Documentos/Codificacao/YUVSequences/B/MarketPlace_1920x1080_60fps_10bit_420.yuv';
width = 1920;
height = 1080;
bitDepth = 10;
nFrames = 600;
skip = [1, 4, 15, 60, 60, 60];
if bitDepth==8
    bytes = 1.5*width*height;
else
    bytes = 3*width*height;
end

% Formato de cada linha no arquivo CSV
fid = fopen("format.txt", "r");
format = fgetl(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName2.txt","r");
columnsName = fgets(fid);
fclose(fid);

% Block sizes
bs = [128, 64, 32, 16, 8, 4];
% Inicializa os arquivos CSV
%fids1 = [0, 0, 0, 0, 0, 0];
fids2 = [0, 0, 0, 0, 0, 0];
videoName = split(path,"/");
videoName = split(char(videoName(8)),".");
videoName = char(videoName(1));
fileName = videoName;
for i=1:6
    %fids1(i)=fopen(strcat(videoName,"_",num2str(bs(i)),"x",num2str(bs(i)),"_B.csv"),"w");
    fids2(i)=fopen(strcat(videoName,"_",num2str(bs(i)),"x",num2str(bs(i)),"_Skip",num2str(skip(i)),"_O.csv"),"w");
    %fprintf(fids1(i),"%s","Bloco");
    fprintf(fids2(i),"%s",columnsName);
end

% Abre o arquivo do vídeo e realiza os cálculos para cada frame a para cada
% tamanho de bloco
fidVideo = fopen(path,"r");
for i=1:6
    disp(strcat("Gerando blocos de tamanho ", num2str(bs(i)),"x",num2str(bs(i))));
    for j=1:skip(i):nFrames
        disp(strcat("Frame ", num2str(j), " de ", num2str(nFrames)));
        [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
        bY = blocks(y, width, height, bs(i), bs(i));
        [~, ~, nBlocks] = size(bY);
        blocksResults = zeros(nBlocks,87);
        parfor k=1:nBlocks
            block = bY(:,:,k);
            s = sobel(block);
            r = roberts(block);
            p = prewitt(block);
            m = media(block);
            e = desvio_variancia(block);
            blockm = medfilt2(block); %Bloco após filtro mediana
            blockh = histeq(block); %Bloco após equalização de histograma
            sm = sobel(blockm);
            rm = roberts(blockm);
            pm = prewitt(blockm);
            mm = media(blockm);
            em = desvio_variancia(blockm);
            sh = sobel(blockh);
            rh = roberts(blockh);
            ph = prewitt(blockh);
            mh = media(blockh);
            eh = desvio_variancia(blockh);
            blocksResults(k,:)=[s r p m e sm rm pm mm em sh rh ph mh eh];
        end
        for l=1:nBlocks
            fprintf(fids2(i), format, blocksResults(l,:));
        end
        if skip(i)>1 && j+skip(i)<=nFrames
            fseek(fidVideo,(skip(i)-1)*bytes,0);
        end
    end
    frewind(fidVideo);
    fclose(fids2(i));
end
disp("Fechando arquivos");
fclose(fidVideo);
disp("Fim");

% % Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(uint8(0.25*bY(:,:, i)));
% end