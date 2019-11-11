function [meanGv, meanGh, meanGUR, meanGUL] = prewitt(block)
block = double(block);
Gx = [-1  0  1;
      -1  0  1;
      -1  0  1];
Gy = [-1 -1 -1;
       0  0  0;
       1  1  1];
Gv = abs(imfilter(block, Gx, 'replicate'));
Gh = abs(imfilter(block, Gy, 'replicate'));
meanGv = mean2(Gv);
meanGh = mean2(Gh);
Gx = [ 0  1  1;
      -1  0  1;
      -1 -1  0];
Gy = [-1 -1  0;
      -1  0  1;
       0  1  1];
Gur = abs(imfilter(block, Gx, 'replicate'));
Gul = abs(imfilter(block, Gy, 'replicate'));
meanGUR = mean2(Gur);
meanGUL = mean2(Gul);
end