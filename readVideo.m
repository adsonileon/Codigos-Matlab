% Descrição %
    % Lê um frame de um arquivo YUV e retorna blocos de luminância e
    % crominância. Os blocos de luminância e crominância são retornados em
    % uma matriz 3D. A primeira e a segunda dimensão indicam o tamanho do
    % bloco em altura e lagura, respectivamente. A terceira dimensão indica
    % o número do bloco.
% Entradas %
    % path       : caminho do arquivo YUV
    % width      : largura do vídeo (número de colunas)
    % height     : altura  do vídeo (número de linhas)
    % nFrame     : número  do frame que deve ser lido do vídeo
    % blockSizeW : tamanho da largura do bloco
    % blockSizeH : tamanho da  altura do bloco
    % components : 1 indica que somente os componentes de luminância devem
    %              ser quebrados em blocos, 2 ou 3 indicam que somente os
    %              componentes de crominância devem ser quebrados em blocos
    %              e 4 indica que todos os três componentes devem ser
    %              quebrados em blocos.
% Saídas %
    % bY         : blocos de luminância  (matriz 3D)
    % bU         : blocos de crominância (matriz 3D)
    % bV         : blocos de crominância (matriz 3D)
function [bY, bU, bV] = readVideo(path, width, height, bitDepth, nFrame, blockSizeW, blockSizeH, components)
% Lê o arquivo YUV a partir da função yuvRead
[Y,U,V] = yuvRead(path, width, height, nFrame, bitDepth);
bY = 0;
bU = 0;
bV = 0;
if components == 1
    bY = blocks(Y(:,:,:), width,   height,   blockSizeW, blockSizeH);
elseif components == 2
    bU = blocks(U(:,:,:), width/2, height/2, blockSizeW, blockSizeH);
elseif components == 3
    bV = blocks(V(:,:,:), width/2, height/2, blockSizeW, blockSizeH);
else
    bY = blocks(Y(:,:,:), width,   height,   blockSizeW, blockSizeH);
    bU = blocks(U(:,:,:), width/2, height/2, blockSizeW, blockSizeH);
    bV = blocks(V(:,:,:), width/2, height/2, blockSizeW, blockSizeH);
end
end

