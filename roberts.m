function r = roberts(block)
block = double(block);
Gx = [-1 0;
       0 1];
Gy = [0 -1;
      1  0];
Gul = imfilter(block, Gx, 'replicate');
Gur = imfilter(block, Gy, 'replicate');
mGur = mean2(abs(Gur));
mGul = mean2(abs(Gul));
qGur = quantis(abs(Gur));
qGul = quantis(abs(Gul));
[magD, dirD] = imgradient(Gul, Gur);
mMagD = mean2(magD);
mDirD = mean2(dirD);
qMagD = quantis(magD);
qDirD = quantis(dirD);
mGur_mGul = div(mGur,mGul);
qGur_qGul = div(qGur,qGul);
r = [mGur qGur mGul qGul mMagD qMagD mDirD qDirD mGur_mGul qGur_qGul];
end