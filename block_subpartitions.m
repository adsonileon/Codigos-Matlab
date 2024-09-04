function [num_subpartitions, hor_blocks, ver_blocks] = block_subpartitions(frame, block_width, block_height, x, y)
    block = zeros(1, block_height, block_width, 'uint8');
    block(:,:,:) = frame(y+1:y+block_height, x+1:x+block_width); %pega o bloco inteiro

    %pegas subpartições do isp
    %somente 4 subpartições (duas horizontais e duas verticais) para blocos 4x8 e 8x4
    if (block_width == 4 && block_height == 8) || (block_width == 8 && block_height == 4)
        num_subpartitions = 2;
        half_width = block_width / 2; %metade da largura
        half_height = block_height / 2; %metade da altura

        hor_blocks = zeros(2, half_height, block_width); %duas subpartições horizontais (metade da altura)
        ver_blocks = zeros(2, block_height, half_width); %duas subpartiçoes verticais (metade da largura)

        hor_blocks(1,:,:) = block(:, 1:half_height, :); %pega a primeira subpartição horizontal
        hor_blocks(2,:,:) = block(:, half_height+1:half_height*2, :); %pega a segunda subpartição horizontal

        ver_blocks(1,:,:) = block(:, :, 1:half_width); %pega a primeira subpartição vertical
        ver_blocks(2,:,:) = block(:, :, half_width+1:half_width*2); %pega a segunda subpartição vertical
    else %outros tamanhos possuem 8 subpartições (quatro horizontais e quatro verticais)
        num_subpartitions = 4;
        quarter_width = block_width / 4; %um quarto da largura
        quarter_height = block_height / 4; %um quarto da altura

        hor_blocks = zeros(4, quarter_height, block_width); %quatro subpartições horizontais (um quarto da altura)
        ver_blocks = zeros(4, block_height, quarter_width); %quatro subpartiçoes verticais (um quarto da largura)

        hor_blocks(1,:,:) = block(:, 1:quarter_height, :); %pega a primeira subpartição horizontal
        hor_blocks(2,:,:) = block(:, quarter_height+1:quarter_height*2, :); %pega a segunda subpartição horizontal
        hor_blocks(3,:,:) = block(:, quarter_height*2+1:quarter_height*3, :); %pega a terceira subpartição horizontal
        hor_blocks(4,:,:) = block(:, quarter_height*3+1:quarter_height*4, :); %pega a segunda subpartição horizontal

        ver_blocks(1,:,:) = block(:, :, 1:quarter_width); %pega a primeira subpartição vertical
        ver_blocks(2,:,:) = block(:, :, quarter_width+1:quarter_width*2); %pega a segunda subpartição vertical
        ver_blocks(3,:,:) = block(:, :, quarter_width*2+1:quarter_width*3); %pega a terceira subpartição vertical
        ver_blocks(4,:,:) = block(:, :, quarter_width*3+1:quarter_width*4); %pega a quarta subpartição vertical    
    end
end
