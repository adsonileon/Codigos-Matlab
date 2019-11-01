% Descrição %
    % Recebe um frame (de crominância ou luminância) e o divide em blocos
    % de tamanho blockSizeW x blockSizeH.
% Entradas %
    % frame      : as matrizes que representam os frames
    % width      : a largura dos frames
    % height     : a altura  dos frames
    % blockSizeW : a largura do bloco
    % blockSizeH : a altura  do bloco
% Saídas %
    % b          : uma matriz 4D, onde a primeira e a segunda dimensão
    %              indicam a altura e a largura do bloco, respectivamente,
    %              a terceira dimensão representa o número do bloco no
    %              frame e a quarta dimensão representa o número do frame.
function [b] = blocks(frames, nFrames, width, height, blockSizeW, blockSizeH)
% Calcula a quantidade de blocos de tamanho blockSizeW x blockSizeH que
% existirão em um frame de tamanho width x height
nBlocksW = floor(width/blockSizeW);
nBlocksH = floor(height/blockSizeH);
% Inicializa a matriz de blocos que será retornada
b = zeros(blockSizeH, blockSizeW, nBlocksH*nBlocksW, nFrames, 'uint8');
bNumber = 1;
% Divide cada um dos frames em blocos de tamanho blockSizeW x blockSizeH
for i=1:nFrames
    for j=1:blockSizeH:height
        jEnd = j+blockSizeH-1;
        jEnd = min(height, jEnd);
        for k=1:blockSizeW:width
            kEnd = k+blockSizeW-1;
            kEnd = min(width, kEnd);
            % Guarda somente os blocos que são do tamanho blockSizeW x
            % blockSizeH
            if jEnd-j+1==blockSizeH && kEnd-k+1==blockSizeW
                b(:,:,bNumber, i)=frames(j:jEnd,k:kEnd,i);
                bNumber=bNumber+1;
            end
        end
    end
end
end