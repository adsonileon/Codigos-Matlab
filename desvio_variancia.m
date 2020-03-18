function e = desvio_variancia(block)
[blockSizeH, blockSizeW] = size(block);
dsH = std(double(block),0,2); %Desvios horizontais (para cada linha)
dsV = std(double(block),0,1); %Desvios verticais (para cada coluna)
dsUR = zeros(blockSizeW+blockSizeH-1,1);
dsUL = zeros(blockSizeW+blockSizeH-1,1);
vsH = var(double(block),0,2); %Variâncias horizontais (para cada linha)
vsV = var(double(block),0,1); %Variâncias verticais (para cada coluna)
vsUR = zeros(blockSizeW+blockSizeH-1,1);
vsUL = zeros(blockSizeW+blockSizeH-1,1);

bw     = blockSizeW;
bh     = blockSizeH;
startl = -bh+1;
endl   = bw-1;
if bw ~= bh
    if bw > bh
        startr = -bw+1;
        endr   = bh-1;
        bh = bw;
    else
        startr = -bh+1;
        endr   = bw-1;
        bw = bh;
    end
end

for i=startr:endr
    [urIndI, urIndJ] = digitalLine(-1, i, bw, bh); %up right = -1 
    urPixels = zeros(size(urIndI,1),1);
    for j=1:size(urIndI)
        if urIndI(j) <= blockSizeH && urIndJ(j) <= blockSizeW
            urPixels(j) = double(block(urIndI(j),urIndJ(j)));
        else
            urPixels(j) = -1;
        end
    end
    urPixels(urPixels == -1) = [];
    dsUR(i+bw) = std(urPixels);
    vsUR(i+bw) = var(urPixels);
end

for i=startl:endl
    [ulIndI, ulIndJ] = digitalLine(1, i, bw, bh); %up left = 1
    ulPixels = zeros(size(ulIndI,1),1);
    for j=1:size(ulIndI)
        if ulIndI(j) <= blockSizeH && ulIndJ(j) <= blockSizeW
            ulPixels(j) = double(block(ulIndI(j),ulIndJ(j)));
        else
            ulPixels(j) = -1;
        end
    end
    ulPixels(ulPixels == -1) = [];
    dsUL(i+blockSizeH) = std(ulPixels);
    vsUL(i+blockSizeH) = var(ulPixels);
end
dH = mean(dsH);
dV = mean(dsV);
dUR = mean(dsUR);
dUL = mean(dsUL);
vH = mean(vsH);
vV = mean(vsV);
vUR = mean(vsUR);
vUL = mean(vsUL);
e = [dH dV dUR dUL vH vV vUR vUL];
end