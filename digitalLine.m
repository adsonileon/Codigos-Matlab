function [indI, indJ] = digitalLine(r, n, blockSizeW, blockSizeH)
if r == 1 || r == -1
    indI = zeros(blockSizeH-abs(n),1);
    indJ = zeros(blockSizeH-abs(n),1);
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
elseif r == 0
    indI = zeros(blockSizeH,1);
    indJ = zeros(blockSizeH,1);
    for i=1:blockSizeH
        j = ceil(r*i)+n;
        indI(i)=i;
        indJ(i)=j;
    end
else
    indI = zeros(blockSizeW,1);
    indJ = zeros(blockSizeW,1);
    for j=1:blockSizeW
        i = ceil(j/r)+n;
        indI(j)=i;
        indJ(j)=j;
    end
    
end
end