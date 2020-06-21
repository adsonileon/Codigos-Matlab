function [b] = block(frame, blockSizeW, blockSizeH, i, iEnd, j, jEnd)
m = uint16(512); % Valor médio para 10 bits
b = m(ones(blockSizeH+2, blockSizeW+2, 'uint16'));
if i>=3 && j>=3
    b(:,:)=frame(i-2:iEnd,j-2:jEnd);
elseif i>=3
    b(:,3:blockSizeW+2)=frame(i-2:iEnd,j:jEnd);
elseif j>=3
    b(3:blockSizeH+2,:)=frame(i:iEnd,j-2:jEnd);
else
    b(3:blockSizeH+2, 3:blockSizeW+2)=frame(i:iEnd,j:jEnd);
end
end