function [indI, indJ] = digitalLine(r, n, blockSizeW, blockSizeH)
indI = zeros(blockSizeH-abs(n),1);
indJ = zeros(blockSizeW-abs(n),1);
if n <= 0
    if r==-1
        ini = 1;
        fim = blockSizeH+n;
    else
        ini = abs(n)+1;
        fim = blockSizeH;
    end
elseif r==-1
    ini = n+1;
    fim = blockSizeH;
else
    ini = 1;
    fim = blockSizeH-n;
end
p = 1;
for i=ini:fim
    j = ceil(r*i)+n;
    if j < 0
        j = j+blockSizeW+1;
    end
    indI(p)=i;
    indJ(p)=j;
    p=p+1;
end
end