clear; clc;
% Parâmetros relacionados ao vídeo
path = 'D:\Adson\YUVSequences\';
path2 = 'D:\Adson\Calculos\';
videos = {'A1\Tango2_3840x2160_60fps_10bit_420.yuv', 'A2\CatRobot_3840x2160_60fps_10bit_420.yuv', 'B\MarketPlace_1920x1080_60fps_10bit_420.yuv', 'F\ArenaOfValor_1920x1080_60fps_8bit_420.yuv'};
widths = [3840, 3840, 1920, 1920];
heights = [2160, 2160, 1080, 1080];
bitDepths = [10, 10, 10, 8];
nsFrames = [294, 300, 600, 600];
% oldSkips = [0, 4, 15, 60, 60; 0, 31, 31, 31, 31];
% skips = [0, 1, 2, 6, 20; 0, 1, 1, 5, 15];

% Block sizes
bw = [4, 4, 4, 4, 8, 8, 8, 8, 16, 16, 16, 16, 32, 32, 32, 32, 64];
bh = [4, 8, 16, 32, 4, 8, 16, 32, 4, 8, 16, 32, 4, 8, 16, 32, 64];

% Formato de cada linha no arquivo CSV
fid = fopen("format.txt", "r");
format = fgetl(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName.txt","r");
columnsName = fgets(fid);
fclose(fid);

for v=1:4
%for v=2:2
    
    if bitDepths(v)==8
        bytes = 1.5*widths(v)*heights(v);
    else
        bytes = 3*widths(v)*heights(v);
    end
    
    % Inicializa os arquivos CSV
    fids = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    videoName = split(char(videos(v)),"\");
    videoName = split(char(videoName(2)),".");
    videoName = char(videoName(1));
    fileName = strcat(path2,videoName);
    for i=1:1
    %for i=17:17
        fids(i)=fopen(strcat(fileName,"_",num2str(bw(i)),"x",num2str(bh(i)),".csv"),"w");
        fprintf(fids(i),"%s",columnsName);
    end

    % Abre o arquivo do vÃ­deo e realiza os cÃ¡lculos para cada frame a para cada
    % tamanho de bloco
    fidVideo = fopen(strcat(path,char(videos(v))),"r");
    for i=1:17
    %for i=17:17
        disp(char(videos(v)));
        disp(strcat("Gerando blocos de tamanho ", num2str(bw(i)),"x",num2str(bh(i))));
        nof = 1;
        for j=1:8:nsFrames(v)
        %for j=1:1
            [y, ~, ~] = yuvRead(fidVideo, widths(v), heights(v), bitDepths(v));
            disp(strcat("Frame ", num2str(nof), " de ", num2str(ceil(nsFrames(v)/8))));
            bY = blocks(y, widths(v), heights(v), bw(i), bh(i));
            [~, ~, nBlocks] = size(bY);
            blocksResults = zeros(nBlocks,1233);
            wb = parwaitbar(nBlocks);
            parfor k=1:nBlocks
                block = bY(:,:,k);
                s = sobel(block);
                r = roberts(block);
                p = prewitt(block);
                m = media(block);
                e = desvio_variancia(block);
                blockm = medfilt2(block); %Bloco após filtro mediana
                blockc = imadjust(block); %Bloco após contraste
                sm = sobel(blockm);
                rm = roberts(blockm);
                pm = prewitt(blockm);
                mm = media(blockm);
                em = desvio_variancia(blockm);
                sc = sobel(blockc);
                rc = roberts(blockc);
                pc = prewitt(blockc);
                mc = media(blockc);
                ec = desvio_variancia(blockc);
                blocksResults(k,:)=[s r p m e sm rm pm mm em sc rc pc mc ec];
                wb.progress();
            end
            xul = 0;
            yul = 0;
            xbr = bw(i)-1;
            ybr = bh(i)-1;
            for l=1:nBlocks
                fprintf(fids(i), format, (nof-1)*7, xul, yul, xbr, ybr, blocksResults(l,:));
                xul = xul + bw(i);
                xbr = xbr + bw(i);
                if xul >= widths(v) || xbr >= widths(v)
                    yul = yul + bh(i);
                    ybr = ybr + bh(i);
                    xul = 0;
                    xbr = bw(i)-1;
                end
            end
            if j+8<=nsFrames(v)
                fseek(fidVideo,7*bytes,0);
            end
            nof=nof+1;
        end
        frewind(fidVideo);
        fclose(fids(i));
    end
    fclose(fidVideo);
end

% % Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(uint8(0.25*bY(:,:, i)));
% end