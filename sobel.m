function s = sobel(block)
    block = double(squeeze(block));
    Gx = [-1 0 1;
          -2 0 2;
          -1 0 1];
    Gy = [-1 -2 -1;
           0  0  0;
           1  2  1];
    Gv = imfilter(block, Gx, 'replicate');
    Gh = imfilter(block, Gy, 'replicate');
    mGv = mean2(abs(Gv));
    mGh = mean2(abs(Gh));
    [magVH, dirVH] = imgradient(Gv, Gh);
    mMagVH = mean2(magVH);
    mDirVH = mean2(dirVH);
    s = [mGv mGh mMagVH mDirVH];
end