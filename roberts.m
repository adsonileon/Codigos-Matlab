function [meanGUR, meanGUL] = roberts(block)
block = double(block);
Gx = [-1 0;
       0 1];
Gy = [0 -1;
      1  0];
Gul = abs(imfilter(block, Gx, 'replicate'));
Gur = abs(imfilter(block, Gy, 'replicate'));
meanGUR = mean2(Gur);
meanGUL = mean2(Gul);
end