clear; clc;
%Caminho da pasta principal onde estão os vídeos
path_videos = "/media/pc-faraday/67b63062-c831-4d62-8fbe-11385746955f/SITI-15/";

%Caminho do CSV (dataset), de onde serão lidas as linhas (exemplos) que devem indicar para
%qual vídeo, número do frame, tamanho do bloco, e posições x e y os filtros
%devem ser calculados
path_csv = "example_dataset.csv";

%Caminho do CSV (dataset) onde as features geradas pelos features serão
%guardadas. Este arquivo será criado, então não pode ser o mesmo nome do
%dataset original para não sobreescrever.
path_csv_out = "dataset_img_features.csv";

%Esta parte lê do arquivo "format_specifier.txt" os especificadores de formato
%Serve para conseguir escrever os valores de saída dos filtros no arquivo
%.csv e para evitar de ter que colocar vários especificadores de formado no
%código na hora de chamar a função que escreve o arquivo (fprintf)
file = fopen("format_specifier.txt", "r");
if file == -1
    error("Erro ao abrir o arquivo: format_specifier.txt");
end
format_specifier = fgetl(file);
fclose(file);

%Esta parte lê do arquivo "columns_name" o nome que cada coluna (feature)
%terá no arquivo de saída.
%Também é para facilitar e não precisar colocar o nome de cada coluna aqui
%no código.
%Caso a quantidade de features ou o tipo de features mude, é necessário
%modificar os arquivos 'format_specifier' e 'columns_name'.
file = fopen("columns_name.txt","r");
if file == -1
    error("Erro ao abrir o arquivo: columns_name.txt");
end
columns_name = fgets(file);
fclose(file);

samples = strings(0);
file = fopen(path_csv, "r");
if file == -1
    error("Erro ao abrir o arquivo: %s", path_csv);
end

%Aqui os exemplos (linhas) são lidos do arquivo de entrada (CSV) para serem
%processados pelo matlab
fgets(file); %pula a linha do cabeçalho (nome das colunas), remover caso csv nao possua cabeçalho (incomum)
while ~feof(file)
    line = fgets(file);
    samples{end+1} = strtrim(line);  % adiciona o exemplo ao array de exemplos
end
fclose(file);

file_out = fopen(path_csv_out, "w+"); %abre o arquivo de saída
if file_out == -1
    error("Erro ao abrir o arquivo de saída: %s", path_csv_out);
end
fprintf(file_out, "%s", columns_name); %escreve o nome das colunas no arquivo de saída
fclose(file_out);

%Numero de exemplos que precisam ser processados
n_samples = length(samples); 

videos = zeros(1, n_samples, 'uint32');
frames = zeros(1, n_samples, 'uint32');
xs = zeros(1, n_samples, 'uint32');
ys = zeros(1, n_samples, 'uint32');
widths = zeros(1, n_samples, 'uint32');
heights = zeros(1, n_samples, 'uint32');
qps = zeros(1, n_samples, 'uint32');
classes = zeros(1, n_samples, 'uint32');
%96 features são calculadas no máximo pro bloco
%No caso de blocos 8x4 e 4x8, são calculadas 48 features pois possui duas
%subparticções ao invés de quatro
%Atualmente, para a terceira e quarta subpartição dos blocos 4x8 e 8x4, os
%valores são zerados no arquivo de saída (deve possuir numero consistente
%de colunas)
features = zeros(n_samples, 96, 'double');

%parfor realiza o processamento em paralelo
wb = parwaitbar(n_samples);
parfor i=1:n_samples
    sample = samples(i); %acessa o exemplo i
    values = split(sample,","); %quebra a string pela virgura (valores de cada coluna)
    %aqui PRECISA SER ADAPTADO conforme o dataset (csv). No caso do dataset
    %exemplo, as colunas seguem a seguinte ordem:
    %video,poc,x,y,width,height,qp,classe
    videos(1,i) = str2num(char(values(1)));
    frames(1,i) = str2num(char(values(2)));
    xs(1,i) = str2num(char(values(3)));
    ys(1,i) = str2num(char(values(4)));
    widths(1,i) = str2num(char(values(5)));
    heights(1,i) = str2num(char(values(6)));
    qps(1,i) = str2num(char(values(7)));
    classes(1,i) = str2num(char(values(8)));
    
    %A FUNÇÃO verifyVideo PRECISA SER ADAPTADA DE ACORDO COM O DATASET
    %Ela recebe o número de um vídeo e retorna o caminho para este vídeo, a
    %largura do vídeo, altura, e bitdepth
    [video,width,height,bitDepth] = verifyVideo(videos(1,i));
    
    %abre o arquivo yuv do video
    arquivo_video = fopen(strcat(path_videos, video), "r");
    if arquivo_video == -1
        error("Erro ao abrir o vídeo no caminho: %s", strcat(path_videos, video));
    end
    if bitDepth==8
        bytes = 1.5*width*height;
    else
        bytes = 3*width*height;
    end
    %ajusta o ponteiro do arquivo para o frame correto
    fseek(arquivo_video,frames(1,i)*bytes,'bof');
    %faz a leitura do canal de luminãncia do frame
    y = yRead(arquivo_video, width, height, bitDepth);
    fclose(arquivo_video);
    %pega as subpartições sobre as quais as features são calculadas
    [num_subpartitions, hor_subpartitions, ver_subpartitions] = block_subpartitions(y,widths(1,i),heights(1,i),xs(1,i),ys(1,i));
    
    %inicializa as variáveis onde os valores das features serão guardados
    sobel_gh = zeros(1, 8, 'double'); %média do gradiente horizontal do sobel, uma para cada subpartição (8 subpartições no máximo)
    sobel_gv = zeros(1, 8, 'double'); %média do gradiente vertical do sobel, uma para cada subpartição
    sobel_mag = zeros(1, 8, 'double'); %média da magnitude dos gradientes do sobel, uma para cada subpartição
    sobel_dir = zeros(1, 8, 'double'); %média da direção dos gradientes do sobel, uma para cada subpartição
    
    prewitt_gh = zeros(1, 8, 'double'); %média do gradiente horizontal do prewitt, uma para cada subpartição (8 subpartições no máximo)
    prewitt_gv = zeros(1, 8, 'double'); %média do gradiente vertical do prewitt, uma para cada subpartição (8 subpartições no máximo)
    prewitt_mag = zeros(1, 8, 'double'); %média da magnitude dos gradientes do prewitt, uma para cada subpartição
    prewitt_dir = zeros(1, 8, 'double'); %média da direção dos gradientes do prewitt, uma para cada subpartição
    
    desvio_h = zeros(1, 8, 'double'); %média do desvio padrão na horizontal (desvio padrão das linhas no bloco), uma para cada subpartição
    desvio_v = zeros(1, 8, 'double'); %média do desvio padrão na vertical (desvio padrão das colunas no bloco), uma para cada subpartição
    
    variancia_h = zeros(1, 8, 'double'); %média da variância na horizontal, uma para cada subpartição
    variancia_v = zeros(1, 8, 'double'); %média da variância na vertical, uma para cada subpartição
    for subpartition=1:num_subpartitions
        %guarda o resultado das features para as subpartições horizontais
        %nas primeiras 4 posições, e para as subpartições verticais nas 4
        %últimas posições. Blocos 4x8 e 8x4 que possuem apenas 2 subpartições por direção irão resultar
        %em features zeradas para as posições 3, 4, 7, e 8.
        sobel_return = sobel(hor_subpartitions(subpartition,:,:));
        sobel_gh(1, subpartition) = sobel_return(1);
        sobel_gv(1, subpartition) = sobel_return(2);
        sobel_mag(1, subpartition) = sobel_return(3);
        sobel_dir(1, subpartition) = sobel_return(4);
        
        sobel_return = sobel(ver_subpartitions(subpartition,:,:));
        sobel_gh(1, 4+subpartition) = sobel_return(1);
        sobel_gv(1, 4+subpartition) = sobel_return(2);
        sobel_mag(1, 4+subpartition) = sobel_return(3);
        sobel_dir(1, 4+subpartition) = sobel_return(4);
        
        prewitt_return = prewitt(hor_subpartitions(subpartition,:,:));
        prewitt_gh(1, subpartition) = prewitt_return(1);
        prewitt_gv(1, subpartition) = prewitt_return(2);
        prewitt_mag(1, subpartition) = prewitt_return(3);
        prewitt_dir(1, subpartition) = prewitt_return(4);
        
        prewitt_return = prewitt(ver_subpartitions(subpartition,:,:));
        prewitt_gh(1, 4+subpartition) = prewitt_return(1);
        prewitt_gv(1, 4+subpartition) = prewitt_return(2);
        prewitt_mag(1, 4+subpartition) = prewitt_return(3);
        prewitt_dir(1, 4+subpartition) = prewitt_return(4);
        
        variancia_desvio_return = desvio_variancia(hor_subpartitions(subpartition,:,:));
        variancia_h(1, subpartition) = variancia_desvio_return(1);
        variancia_v(1, subpartition) = variancia_desvio_return(2);
        desvio_h(1, subpartition) = variancia_desvio_return(3);
        desvio_v(1, subpartition) = variancia_desvio_return(4);
        
        variancia_desvio_return = desvio_variancia(ver_subpartitions(subpartition,:,:));
        variancia_h(1, 4+subpartition) = variancia_desvio_return(1);
        variancia_v(1, 4+subpartition) = variancia_desvio_return(2);
        desvio_h(1, 4+subpartition) = variancia_desvio_return(3);
        desvio_v(1, 4+subpartition) = variancia_desvio_return(4);
    end
    features(i,:)=[sobel_gh sobel_gv sobel_mag sobel_dir prewitt_gh prewitt_gv prewitt_mag prewitt_dir variancia_h variancia_v desvio_h desvio_v];
    wb.progress();
end

file_out = fopen(path_csv_out, "a"); %abre o arquivo de saída
if file_out == -1
    error("Erro ao abrir o arquivo de saída: %s", path_csv_out);
end
for i=1:n_samples
    fprintf(file_out,format_specifier,videos(1,i),frames(1,i),xs(1,i),ys(1,i),widths(1,i),heights(1,i),qps(1,i),features(i,:),classes(1,i));
end
fclose(file_out);
