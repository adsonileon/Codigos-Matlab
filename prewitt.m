function p = prewitt(block)
    block = double(squeeze(block));
    Gx = [-1  0  1;
          -1  0  1;
          -1  0  1];
    Gy = [-1 -1 -1;
           0  0  0;
           1  1  1];
    Gv = imfilter(block, Gx, 'replicate');
    Gh = imfilter(block, Gy, 'replicate');
    mGv = mean2(abs(Gv));
    mGh = mean2(abs(Gh));
    [magVH, dirVH] = imgradient(Gv, Gh);
    mMagVH = mean2(magVH);
    mDirVH = mean2(dirVH);
    p = [mGv mGh mMagVH mDirVH];
end