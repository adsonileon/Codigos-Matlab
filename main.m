clear; clc;
% Parâmetros
path = '/home/ileon/Documentos/Codificacao/YUVSequences/A2/CatRobot_3840x2160_60fps_10bit_420.yuv';
width = 3840;
height = 2160;
bitDepth = 10;
nFrames = 300;
skip = 30;

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
    fids2(i)=fopen(strcat(videoName,"_",num2str(bs(i)),"x",num2str(bs(i)),"_O.csv"),"w");
    %fprintf(fids1(i),"%s","Bloco");
    fprintf(fids2(i),"%s",columnsName);
end

% Abre o arquivo do vídeo e realiza os cálculos para cada frame a para cada
% tamanho de bloco
fidVideo = fopen(path,"r");
for i=1:skip:nFrames
    disp(strcat("Frame ", num2str(i), " de ", num2str(nFrames)));
    [y, ~, ~] = yuvRead(fidVideo, width, height, bitDepth);
    for j=1:6
        disp(strcat("Gerando blocos de tamanho ", num2str(bs(j)),"x",num2str(bs(j))));
        bY = blocks(y, width, height, bs(j), bs(j));
        [~, ~, nBlocks] = size(bY);
        blocksResults = zeros(nBlocks,87);
        disp("Calculando os operadores para cada bloco");
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
            fprintf(fids2(j), format, blocksResults(l,:));
        end
    end
    if i+30<=nFrames
        if bitDepth==8
            bytes = 1.5*width*height*skip;
        else
            bytes = 3*width*height*skip;
        end
        fseek(fidVideo, bytes, 0);
    end
end
disp("Fechando arquivos");
for i=1:6
    %fclose(fids1(i));
    fclose(fids2(i));
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