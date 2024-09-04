function e = desvio_variancia(block)
    block = double(squeeze(block));
    dsH = std(block,0,2); %Desvios horizontais (para cada linha)
    dsV = std(block,0,1); %Desvios verticais (para cada coluna)

    vsH = var(block,0,2); %Variâncias horizontais (para cada linha)
    vsV = var(block,0,1); %Variâncias verticais (para cada coluna)

    dH = mean(dsH); %média dos desvios horizontais
    dV = mean(dsV); %média dos desvios verticais

    vH = mean(vsH); %média das variâncias horizontais
    vV = mean(vsV); %média das variâncias verticais

    e = [vH vV dV dH];
end