function [b] = block(frame, blockSizeW, blockSizeH, i, iEnd, j, jEnd)
m = uint16(512); % Valor médio para 10 bits
b = m(ones(blockSizeH+3, blockSizeW+3, 'uint16'));
if i>=5 && j>=5
    b(2:blockSizeH+3,2:blockSizeW+3)=frame(i-2:iEnd,j-2:jEnd);
    b(1,2:blockSizeW+3)=frame(i-4,j-2:jEnd);
    b(2:blockSizeH+3,1)=frame(i-2:iEnd,j-4);
    b(1,1)=frame(i-4,j-4);
elseif i>=5
    b(1,4:blockSizeW+3)=frame(i-4,j:jEnd);
    b(2:blockSizeH+3,4:blockSizeW+3)=frame(i-2:iEnd,j:jEnd);
elseif j>=5
    b(4:blockSizeH+3,1)=frame(i:iEnd,j-4);
    b(4:blockSizeH+3,2:blockSizeW+3)=frame(i:iEnd,j-2:jEnd);
else
    b(4:blockSizeH+3, 4:blockSizeW+3)=frame(i:iEnd,j:jEnd);
end
end