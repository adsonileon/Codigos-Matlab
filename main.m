clear; clc;
% Parâmetros relacionados ao vídeo
path = '/home/ileon/Documentos/Codificacao/YUVSequences/';
path2 = '/media/ileon/9A94269294267145/Codificacao/ProjetoPCV-PDI/Calculos/';
videos = {'B/MarketPlace_1920x1080_60fps_10bit_420.yuv', 'A2/CatRobot_3840x2160_60fps_10bit_420.yuv'};
widths = [1920, 3840];
heights = [1080, 2160];
bitDepths = [10, 10];
nsFrames = [600, 300];
oldSkips = [0, 4, 15, 60, 60; 0, 31, 31, 31, 31];
skips = [0, 1, 2, 6, 20; 0, 1, 1, 5, 15];

% Block sizes
bs = [128, 64, 32, 16, 8, 4];

% Formato de cada linha no arquivo CSV
fid = fopen("format.txt", "r");
format = fgetl(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName2.txt","r");
columnsName = fgets(fid);
fclose(fid);

for v=1:1
    if bitDepths(v)==8
        bytes = 1.5*widths(v)*heights(v);
    else
        bytes = 3*widths(v)*heights(v);
    end
    
    % Inicializa os arquivos CSV
    %fids1 = [0, 0, 0, 0, 0, 0];
    fids2 = [0, 0, 0, 0, 0, 0];
    videoName = split(char(videos(v)),"/");
    videoName = split(char(videoName(2)),".");
    videoName = char(videoName(1));
    fileName = strcat(path2,videoName);
    for i=2:1:5
        %fids1(i)=fopen(strcat(videoName,"_",num2str(bs(i)),"x",num2str(bs(i)),"_B.csv"),"w");
        fids2(i)=fopen(strcat(fileName,"_",num2str(bs(i)),"x",num2str(bs(i)),"_Skip",num2str(skips(v,i)),"_O.csv"),"w");
        %fprintf(fids1(i),"%s","Bloco");
        fprintf(fids2(i),"%s",columnsName);
    end

    % Abre o arquivo do vídeo e realiza os cálculos para cada frame a para cada
    % tamanho de bloco
    fidVideo = fopen(strcat(path,char(videos(v))),"r");
    for i=2:5
        calculated = 1:oldSkips(v,i):nsFrames(v);
        disp(strcat("Gerando blocos de tamanho ", num2str(bs(i)),"x",num2str(bs(i))));
        nof = 1;
        for j=1:skips(v,i):nsFrames(v)
            [y, ~, ~] = yuvRead(fidVideo, widths(v), heights(v), bitDepths(v));
            if ismember(j,calculated)==false
                disp(strcat("Frame ", num2str(nof), " de ", num2str(nsFrames(v)/skips(v,i))));
                bY = blocks(y, widths(v), heights(v), bs(i), bs(i));
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
            else
                disp(strcat("Frame ", num2str(nof), " de ", num2str(nsFrames(v)/skips(v,i)), " | Já calculado"));
            end
            if skips(v,i)>1 && j+skips(v,i)<=nsFrames(v)
                fseek(fidVideo,(skips(v,i)-1)*bytes,0);
            end
            nof=nof+1;
        end
        frewind(fidVideo);
        fclose(fids2(i));
    end
    disp("Fechando arquivos");
    fclose(fidVideo);
end
disp("Fim");

% % Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(uint8(0.25*bY(:,:, i)));
% end