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
startr = -bw+1;
endr   = bh-1;
if bw ~= bh
    if bw > bh
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
% qDH = quantis(dsH);
% qDV = quantis(dsV);
dUR = mean(dsUR);
dUL = mean(dsUL);
% qDUR = quantis(dsUR);
% qDUL = quantis(dsUL);
vH = mean(vsH);
vV = mean(vsV);
% qVH = quantis(vsH);
% qVV = quantis(vsV);
vUR = mean(vsUR);
vUL = mean(vsUL);
% qVUR = quantis(vsUR);
% qVUL = quantis(vsUL);

dV_dH = div(dV, dH);
% dV__dH = dif(dV,dH);
% dV___dH = dif(dV_dH(:,1),dV_dH(:,2));
% qDV_qDH = div(qDV,qDH);
% qDV__qDH = dif(qDV,qDH);
% qDV___qDH = dif2(qDV_qDH);
dUR_dUL = div(dUR,dUL);
% dUR__dUL = dif(dUR,dUL);
% dUR___dUL = dif(dUR_dUL(:,1),dUR_dUL(:,2));
% qDUR_qDUL = div(qDUR,qDUL);
% qDUR__qDUL = dif(qDUR,qDUL);
% qDUR___qDUL = dif2(qDUR_qDUL);
vV_vH = div(vV,vH);
% vV__vH = dif(vV,vH);
% vV___vH = dif(vV_vH(:,1),vV_vH(:,2));
% qVV_qVH = div(qVV,qVH);
% qVV__qVH = dif(qVV,qVH);
% qVV___qVH = dif2(qVV_qVH);
vUR_vUL = div(vUR,vUL);
% vUR__vUL = dif(vUR,vUL);
% vUR___vUL = dif(vUR_vUL(:,1),vUR_vUL(:,2));
% qVUR_qVUL = div(qVUR,qVUL);
% qVUR__qVUL = dif(qVUR,qVUL);
% qVUR___qVUL = dif2(qVUR_qVUL);

% e = [dV qDV dH qDH dUR qDUR dUL qDUL dV_dH dV__dH dV___dH qDV_qDH qDV__qDH qDV___qDH dUR_dUL dUR__dUL dUR___dUL qDUR_qDUL qDUR__qDUL qDUR___qDUL vH qVH vV qVV vUR qVUR vUL qVUL vV_vH vV__vH vV___vH qVV_qVH qVV__qVH qVV___qVH vUR_vUL vUR__vUL vUR___vUL qVUR_qVUL qVUR__qVUL qVUR___qVUL];
e = [dV dH dUR dUL dV_dH dUR_dUL vH vV vUR vUL vV_vH vUR_vUL];
end