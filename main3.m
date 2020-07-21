clear; clc;
% Parâmetros relacionados ao vídeo
% root1 = 'D:\Adson\YUVSequences\NETVC(AV1)\720p\';
root1 = 'D:\Adson\YUVSequences\';
% root2 = 'D:\Adson\Datasets\Angulares_QuatroClasses\';
root2 = 'D:\Adson\Datasets\Angulares_CincoClasses\';
dataSetNames = {'dataset_4x4_4x32.csv', 'dataset_8x4_8x32.csv', 'dataset_16x4_16x32.csv', 'dataset_32x4_32x32.csv', 'dataset_64x64_64x64.csv'};
dataSetCount = {'count_4x4_4x32.txt', 'count_8x4_8x32.txt', 'count_16x4_16x32.txt', 'count_32x4_32x32.txt', 'count_64x64_64x64.txt'};
% dataSetNames = {'dataset_64x64_64x64.csv'};
% dataSetCount = {'count_64x64_64x64.txt'};
% Formato de cada linha no arquivo CSV
fid = fopen("format3.txt", "r");
format = fgetl(fid);
fclose(fid);

% Nome das colunas no arquivo CSV
fid = fopen("columnsName3.txt","r");
columnsName = fgets(fid);
fclose(fid);

for d=1:5
    fidcount = fopen(strcat(root2,char(dataSetCount(d))),"r");
    dataSetName = split(char(dataSetNames(d)),".");
    fidsetnew = fopen(strcat(root2,char(dataSetName(1)),"_features.csv"),"w");
%     fidsetnewfm = fopen(strcat(root2,char(dataSetName(1)),"_featuresFM.csv"),"w");
%     fidsetnewfc = fopen(strcat(root2,char(dataSetName(1)),"_featuresFC.csv"),"w");
    fprintf(fidsetnew,"%s",columnsName);
%     fprintf(fidsetnewfm,"%s",columnsName);
%     fprintf(fidsetnewfc,"%s",columnsName);
    fidset = fopen(strcat(root2,char(dataSetNames(d))),"r");
    fgetl(fidset); %Nome das colunas
    line = fgetl(fidcount);
    while ischar(line)
        nBlocks = str2num(char(line));
%         blockResults = zeros(nBlocks,1233);
        blockResults = zeros(nBlocks,141);
        poc = zeros(1,nBlocks,'double');
        xtl = zeros(1,nBlocks,'uint32');
        ytl = zeros(1,nBlocks,'uint32');
        xbr = zeros(1,nBlocks,'uint32');
        ybr = zeros(1,nBlocks,'uint32');
        class = zeros(1,nBlocks,'uint8');
        ids = zeros(1,nBlocks,'uint8');
        qps = zeros(1,nBlocks,'uint8');
        examples = strings(1,nBlocks);
        for i=1:nBlocks
            examples(1,i) = fgetl(fidset);
            if i==1
               values = split(examples(1,i),",");
               bw = str2num(char(values(2)));
               bh = str2num(char(values(3)));
               vm = uint16(512);
               bY = vm(ones(bh+2, bw+2, nBlocks, 'uint16'));
            end
        end
        wb = parwaitbar(nBlocks);
        parfor i=1:nBlocks
            example = examples(1,i);
            values = split(example,",");
            poc(1,i) = str2num(char(values(5)));
            qps(1,i) = str2num(char(values(4)));
            sequence = char(values(1));
            [video,width,height,bitDepth,skip,id] = verifyVideo(sequence);
            fidVideo = fopen(strcat(root1,video),"r");
            if bitDepth==8
                bytes = 1.5*width*height;
            else
                bytes = 3*width*height;
            end
            fseek(fidVideo,poc(1,i)*skip*bytes,'bof');
            [y,~,~] = yuvRead(fidVideo,width,height,bitDepth);
            xtl(1,i) = str2num(char(values(6)));
            ytl(1,i) = str2num(char(values(7)));
            xbr(1,i) = str2num(char(values(8)));
            ybr(1,i) = str2num(char(values(9)));
            bY(:,:,i) = block(y,bw,bh,ytl(1,i)+1,ybr(1,i)+1,xtl(1,i)+1,xbr(1,i)+1);
            class(1,i) = uint8(char(values(16)));
            ids(1,i) = id;
            fclose(fidVideo);
            s = sobel(bY(:,:,i));
            r = roberts(bY(:,:,i));
            p = prewitt(bY(:,:,i));
            m = media(bY(:,:,i));
            e = desvio_variancia(bY(:,:,i));
            blockm = medfilt2(bY(:,:,i)); %Bloco após filtro mediana
            blockc = imadjust(bY(:,:,i)); %Bloco após contraste
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
            fprintf(fidsetnew,format,returnVideo(ids(1,i)),bw,bh,qps(1,i),poc(1,i),xtl(1,i),xbr(1,i),ytl(1,i),ybr(1,i),blockResults(i,:),char(class(1,i)));
%             fprintf(fidsetnew,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,1:411),char(class(i)));
%             fprintf(fidsetnewfm,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,412:822),char(class(i)));
%             fprintf(fidsetnewfc,format,sequence,bw,bh,qp,poc(i),xtl(i),xbr(i),ytl(i),ybr(i),blockResults(i,823:1233),char(class(i)));
        end
        line = fgetl(fidcount);
    end
    fclose(fidset);
    fclose(fidsetnew);
%     fclose(fidsetnewfm);
%     fclose(fidsetnewfc);
    fclose(fidcount);
end