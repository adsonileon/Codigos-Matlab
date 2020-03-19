function r = roberts(block)
block = double(block);
Gx = [-1 0;
       0 1];
Gy = [0 -1;
      1  0];
Gul = imfilter(block, Gx, 'replicate');
Gur = imfilter(block, Gy, 'replicate');
meanGur = mean2(abs(Gur));
meanGul = mean2(abs(Gul));
[magD, dirD] = imgradient(Gul, Gur);
magD = mean2(magD);
dirD = mean2(dirD);
if meanGur > 0
    meanGul_meanGur = meanGul/meanGur;
else
    meanGul_meanGur = -1;
end
if meanGul > 0
    meanGur_meanGul = meanGur/meanGul;
else
    meanGur_meanGul = -1;
end
r = [meanGur meanGul magD dirD meanGur_meanGul meanGul_meanGur];
end