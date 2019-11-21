% Descrição %
    % Recebe um frame (de crominância ou luminância) e o divide em blocos
    % de tamanho blockSizeW x blockSizeH.
% Entradas %
    % frame      : a matriz que representa o frame
    % width      : a largura do frame
    % height     : a altura  do frame
    % blockSizeW : a largura do bloco
    % blockSizeH : a altura  do bloco
% Saídas %
    % b          : uma matriz 3D, onde a primeira e a segunda dimensão
    %              indicam a altura e a largura do bloco, respectivamente,
    %              e a terceira dimensão representa o número do bloco.
function [b] = blocks(frame, width, height, blockSizeW, blockSizeH)
% Calcula a quantidade de blocos de tamanho blockSizeW x blockSizeH que
% existirão em um frame de tamanho width x height
nBlocksW = floor(width/blockSizeW);
nBlocksH = floor(height/blockSizeH);
% Inicializa a matriz de blocos que será retornada, 3 linhas acima e 3
% colunas a esquerda
m = uint16(512); % Valor médio para 10 bits
b = m(ones(blockSizeH+3, blockSizeW+3, nBlocksH*nBlocksW, 'uint16'));
bNumber = 1;
% Divide cada um dos frames em blocos de tamanho blockSizeW x blockSizeH
for i=1:blockSizeH:height
    iEnd = i+blockSizeH-1;
    iEnd = min(height, iEnd);
    for j=1:blockSizeW:width
        jEnd = j+blockSizeW-1;
        jEnd = min(width, jEnd);
        % Guarda somente os blocos que são do tamanho blockSizeW x
        % blockSizeH
        if iEnd-i+1==blockSizeH && jEnd-j+1==blockSizeW
            if i>=5 && j>=5
                b(2:blockSizeH+3,2:blockSizeW+3,bNumber)=frame(i-2:iEnd,j-2:jEnd);
                b(1,2:blockSizeW+3,bNumber)=frame(i-4,j-2:jEnd);
                b(2:blockSizeH+3,1,bNumber)=frame(i-2:iEnd,j-4);
                b(1,1,bNumber)=frame(i-4,j-4);
            elseif i>=5
                b(1,4:blockSizeW+3,bNumber)=frame(i-4,j:jEnd);
                b(2:blockSizeH+3,4:blockSizeW+3,bNumber)=frame(i-2:iEnd,j:jEnd);
            elseif j>=5
                b(4:blockSizeH+3,1,bNumber)=frame(i:iEnd,j-4);
                b(4:blockSizeH+3,2:blockSizeW+3,bNumber)=frame(i:iEnd,j-2:jEnd);
            else
                b(4:blockSizeH+3, 4:blockSizeW+3,bNumber)=frame(i:iEnd,j:jEnd);
            end
            bNumber=bNumber+1;
        end
    end
end
end