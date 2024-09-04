%Função que lê o canal de luminância de um frame aberto em arquivo, de
%largura = width, altura = height, e bitdepth = 8 ou 10
%No caso de bitdepth igual a 10, os valores são passados para 8 bits
%multiplicando por 1/4
function y = yRead(file, width, height, bitDepth)
if bitDepth == 8
    lengthY = strcat(num2str(width*height), "*uint8");
    y = uint8(fread(file, [width height], lengthY));
else
    lengthY = strcat(num2str(width*height), "*uint16");   
    y = uint16(fread(file, [width height], lengthY));
end

y = y';
if bitDepth == 10
    y = 0.25*y; %vídeos de 10 bits são transformados para 8 bits (valores multiplicados por 1/4)
    y = uint8(y);
end
end
