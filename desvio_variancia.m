function e = desvio_variancia(block, blockSizeW, blockSizeH)
dsH = std(double(block),0,2); %Desvios horizontais (para cada linha)
dsV = std(double(block),0,1); %Desvios verticais (para cada coluna)
dsUR = zeros(blockSizeW+blockSizeH-1,1);
dsUL = zeros(blockSizeW+blockSizeH-1,1);
vsH = var(double(block),0,2); %Variâncias horizontais (para cada linha)
vsV = var(double(block),0,1); %Variâncias verticais (para cada coluna)
vsUR = zeros(blockSizeW+blockSizeH-1,1);
vsUL = zeros(blockSizeW+blockSizeH-1,1);
for i=-blockSizeW+1:blockSizeW-1
    [urIndI, urIndJ] = digitalLine(-1, i, blockSizeW, blockSizeH); %up right = -1 
    [ulIndI, ulIndJ] = digitalLine(1, i, blockSizeW, blockSizeH); %up left = 1
    urPixels = zeros(size(urIndI,1),1);
    ulPixels = zeros(size(ulIndI,1),1);
    for j=1:size(urIndI)
        urPixels(j) = double(block(urIndI(j),urIndJ(j)));
        ulPixels(j) = double(block(ulIndI(j),ulIndJ(j)));
    end
    dsUR(i+blockSizeW) = std(urPixels);
    dsUL(i+blockSizeW) = std(ulPixels);
    vsUR(i+blockSizeW) = var(urPixels);
    vsUL(i+blockSizeW) = var(ulPixels);
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