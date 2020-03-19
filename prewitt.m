function p = prewitt(block)
block = double(block);
Gx = [-1  0  1;
      -1  0  1;
      -1  0  1];
Gy = [-1 -1 -1;
       0  0  0;
       1  1  1];
Gv = imfilter(block, Gx, 'replicate');
Gh = imfilter(block, Gy, 'replicate');
meanGv = mean2(abs(Gv));
meanGh = mean2(abs(Gh));
[magVH, dirVH] = imgradient(Gv, Gh);
magVH = mean2(magVH);
dirVH = mean2(dirVH);
Gx = [ 0  1  1;
      -1  0  1;
      -1 -1  0];
Gy = [-1 -1  0;
      -1  0  1;
       0  1  1];
Gur = imfilter(block, Gx, 'replicate');
Gul = imfilter(block, Gy, 'replicate');
meanGur = mean2(abs(Gur));
meanGul = mean2(abs(Gul));
[magD, dirD] = imgradient(Gur, Gul);
magD = mean2(magD);
dirD = mean2(dirD);

if meanGv > 0
    meanGh_meanGv = meanGh/meanGv;
else
    meanGh_meanGv = -1;
end
if meanGh > 0
    meanGv_meanGh = meanGv/meanGh;
else
    meanGv_meanGh = -1;
end
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
p = [meanGv meanGh magVH dirVH meanGur meanGul magD dirD meanGh_meanGv meanGv_meanGh meanGul_meanGur meanGur_meanGul];
end