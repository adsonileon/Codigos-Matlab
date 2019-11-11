function [meanGUR, meanGUL, magD, dirD] = roberts(block)
block = double(block);
Gx = [-1 0;
       0 1];
Gy = [0 -1;
      1  0];
Gul = imfilter(block, Gx, 'replicate');
Gur = imfilter(block, Gy, 'replicate');
meanGUR = mean2(abs(Gur));
meanGUL = mean2(abs(Gul));
[magD, dirD] = imgradient(Gul, Gur);
magD = mean2(magD);
dirD = mean2(dirD);
end