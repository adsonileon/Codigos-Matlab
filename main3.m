clear; clc;
% Parâmetros relacionados ao vídeo
path = 'D:\Adson\YUVSequences\NETVC(AV1)\720p\';
pathDataSet = 'dataset.csv';
pathDataSetNew = 'dataset_features.csv';
pathDataSetNewFM = 'dataset_featuresFM.csv';
pathDataSetNewFC = 'dataset_featuresFC.csv';
pathCount = 'count.txt';

% Formato de cada linha no arquivo CSV
fid = fopen("format2.txt", "r");
format = fgetl(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName2.txt","r");
columnsName = fgets(fid);
fclose(fid);

fidcount = fopen(strcat(path,pathCount),"r");

fidsetnew = fopen(strcat(path,pathDataSetNew),"w");
fidsetnewfm = fopen(strcat(path,pathDataSetNewFM),"w");
fidsetnewfc = fopen(strcat(path,pathDataSetNewFC),"w");
fprintf(fidsetnew,"%s",columnsName);
fprintf(fidsetnewfm,"%s",columnsName);
fprintf(fidsetnewfc,"%s",columnsName);

fidset = fopen(strcat(path,pathDataSet),"r");
fgetl(fidset); %Nome das colunas
% line = fgetl(fidset);
% values = split(line,",");
% sequence = char(values(1));
% bw = str2num(char(values(2)));
% bh = str2num(char(values(3)));
% poc = str2num(char(values(5)));
% [video,width,height,bitDepth,nframes] = verifyVideo(sequence);
% if bitDepth==8
%     bytes = 1.5*width*height;
% else
%     bytes = 3*width*height;
% end
% fidVideo = fopen(strcat(path,video),"r");
% fseek(fidVideo,poc*8*bytes,'bof');
% [y,~,~] = yuvRead(fidVideo,width,height,bitDepth);
% disp(sequence);
% disp(strcat(num2str(bw),"x",num2str(bh)));
line = fgetl(fidcount);
sequence="nenhuma";
while ischar(line)
    nBlocks = str2num(char(line));
    blockResults = zeros(nBlocks,1233);
    poc = zeros(nBlocks,'uint8');
    xtl = zeros(nBlocks,'uint32');
    ytl = zeros(nBlocks,'uint32');
    xbr = zeros(nBlocks,'uint32');
    ybr = zeros(nBlocks,'uint32');
%     mode = zeros(nBlocks,'uint8');
%     isp = zeros(nBlocks,'uint8');
%     mip = zeros(nBlocks,'uint8');
%     mipt = zeros(nBlocks,'uint8');
%     idx = zeros(nBlocks,'uint8');
%     cost = zeros(nBlocks,'double');
    class = zeros(nBlocks,'uint8');
    for i=1:nBlocks
        example = fgetl(fidset);
        values = split(example,",");
        poc(i) = str2num(char(values(5)));
        if i==1
            if ~strcmp(sequence,char(values(1)))
                if ~strcmp(sequence,"nenhuma")
                    fclose(fidVideo);
                end
                sequence = char(values(1));
                [video,width,height,bitDepth,nframes] = verifyVideo(sequence);
                fidVideo = fopen(strcat(path,video),"r");
                if bitDepth==8
                    bytes = 1.5*width*height;
                else
                    bytes = 3*width*height;
                end
            end
            qp = str2num(char(values(4)));
            bw = str2num(char(values(2)));
            bh = str2num(char(values(3)));
            vm = uint16(512);
            bY = vm(ones(bh+3, bw+3, nBlocks, 'uint16'));
            disp(sequence);
            disp(num2str(qp));
            disp(strcat(num2str(bw),"x",num2str(bh)));
            fseek(fidVideo,poc(i)*8*bytes,'bof');
            [y,~,~] = yuvRead(fidVideo,width,height,bitDepth);
        elseif poc(i)~=poc(i-1)
            fseek(fidVideo,poc(i)*8*bytes,'bof');
            [y,~,~] = yuvRead(fidVideo,width,height,bitDepth);
        end
        xtl(i) = str2num(char(values(6)));
        ytl(i) = str2num(char(values(7)));
        xbr(i) = str2num(char(values(8)));
        ybr(i) = str2num(char(values(9)));
        bY(:,:,i) = block(y,bw,bh,ytl(i)+1,ybr(i)+1,xtl(i)+1,xbr(i)+1);
%         mode(i) = str2num(char(values(10)));
%         isp(i)  = str2num(char(values(11)));
%         mip(i)  = str2num(char(values(12)));
%         mipt(i) = str2num(char(values(13)));
%         idx(i)  = str2num(char(values(14)));
%         cost(i) = str2double(char(values(15)));
        class(i) = uint8(char(values(16)));
    end
    wb = parwaitbar(nBlocks);
    parfor i=1:nBlocks
        blocko = bY(:,:,i);
        s = sobel(blocko);
        r = roberts(blocko);
        p = prewitt(blocko);
        m = media(blocko);
        e = desvio_variancia(blocko);
        blockm = medfilt2(blocko); %Bloco após filtro mediana
        blockc = imadjust(blocko); %Bloco após contraste
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
        blockResults(i,:)=[s r p m e sm rm pm mm em sc rc pc mc ec];
        wb.progress();
    end
    for i=1:nBlocks
        fprintf(fidsetnew,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,1:411),char(class(i)));
        fprintf(fidsetnewfm,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,412:822),char(class(i)));
        fprintf(fidsetnewfc,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,823:1233),char(class(i)));
    end
    line = fgetl(fidcount);
end
fclose(fidset);
fclose(fidsetnew);
fclose(fidsetnewfm);
fclose(fidsetnewfc);
fclose(fidcount);

% for v=1:4    
%     if bitDepths(v)==8
%         bytes = 1.5*widths(v)*heights(v);
%     else
%         bytes = 3*widths(v)*heights(v);
%     end
%     
%     % Inicializa os arquivos CSV
%     fids = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%     videoName = split(char(videos(v)),"\");
%     videoName = split(char(videoName(2)),".");
%     videoName = char(videoName(1));
%     fileName = strcat(path2,videoName);
%     for i=1:1
%     %for i=17:17
%         fids(i)=fopen(strcat(fileName,"_",num2str(bw(i)),"x",num2str(bh(i)),".csv"),"w");
%         fprintf(fids(i),"%s",columnsName);
%     end
% 
%     % Abre o arquivo do vÃ­deo e realiza os cÃ¡lculos para cada frame a para cada
%     % tamanho de bloco
%     fidVideo = fopen(strcat(path,char(videos(v))),"r");
%     for i=1:17
%     %for i=17:17
%         disp(char(videos(v)));
%         disp(strcat("Gerando blocos de tamanho ", num2str(bw(i)),"x",num2str(bh(i))));
%         nof = 1;
%         for j=1:8:nsFrames(v)
%         %for j=1:1
%             [y, ~, ~] = yuvRead(fidVideo, widths(v), heights(v), bitDepths(v));
%             disp(strcat("Frame ", num2str(nof), " de ", num2str(ceil(nsFrames(v)/8))));
%             bY = blocks(y, widths(v), heights(v), bw(i), bh(i));
%             [~, ~, nBlocks] = size(bY);
%             blocksResults = zeros(nBlocks,1233);
%             wb = parwaitbar(nBlocks);
%             parfor k=1:nBlocks
%                 block = bY(:,:,k);
%                 s = sobel(block);
%                 r = roberts(block);
%                 p = prewitt(block);
%                 m = media(block);
%                 e = desvio_variancia(block);
%                 blockm = medfilt2(block); %Bloco após filtro mediana
%                 blockc = imadjust(block); %Bloco após contraste
%                 sm = sobel(blockm);
%                 rm = roberts(blockm);
%                 pm = prewitt(blockm);
%                 mm = media(blockm);
%                 em = desvio_variancia(blockm);
%                 sc = sobel(blockc);
%                 rc = roberts(blockc);
%                 pc = prewitt(blockc);
%                 mc = media(blockc);
%                 ec = desvio_variancia(blockc);
%                 blocksResults(k,:)=[s r p m e sm rm pm mm em sc rc pc mc ec];
%                 wb.progress();
%             end
%             xul = 0;
%             yul = 0;
%             xbr = bw(i)-1;
%             ybr = bh(i)-1;
%             for l=1:nBlocks
%                 fprintf(fids(i), format, (nof-1)*7, xul, yul, xbr, ybr, blocksResults(l,:));
%                 xul = xul + bw(i);
%                 xbr = xbr + bw(i);
%                 if xul >= widths(v) || xbr >= widths(v)
%                     yul = yul + bh(i);
%                     ybr = ybr + bh(i);
%                     xul = 0;
%                     xbr = bw(i)-1;
%                 end
%             end
%             if j+8<=nsFrames(v)
%                 fseek(fidVideo,7*bytes,0);
%             end
%             nof=nof+1;
%         end
%         frewind(fidVideo);
%         fclose(fids(i));
%     end
%     fclose(fidVideo);
% end

% % Exibir um bloco
% nBlocksW = floor(width/blockSizeW);
% nBlocksH = floor(height/blockSizeH);
% for i=1:nBlocksH*nBlocksW
%     subplot(nBlocksH, nBlocksW, i);
%     imshow(uint8(0.25*bY(:,:, i)));
% end