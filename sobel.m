function [meanGv, meanGh, magVH, dirVH, meanGUR, meanGUL, magD, dirD] = sobel(block)
block = double(block);
Gx = [-1 0 1;
      -2 0 2;
      -1 0 1];
Gy = [-1 -2 -1;
       0  0  0;
       1  2  1];
Gv = imfilter(block, Gx, 'replicate');
Gh = imfilter(block, Gy, 'replicate');
meanGv = mean2(abs(Gv));
meanGh = mean2(abs(Gh));
[magVH, dirVH] = imgradient(Gv, Gh);
Gx = [ 0  1  2;
      -1  0  1;
      -2 -1  0];
Gy = [-2 -1  0;
      -1  0  1;
       0  1  2];
Gur = imfilter(block, Gx, 'replicate');
Gul = imfilter(block, Gy, 'replicate');
meanGUR = mean2(abs(Gur));
meanGUL = mean2(abs(Gul));
[magD, dirD] = imgradient(Gur, Gul);
end