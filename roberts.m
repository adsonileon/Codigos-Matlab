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
mGur__mGul = dif(mGur,mGul);
mGur___mGul = dif(mGur_mGul(:,1), mGur_mGul(:,2));
qGur_qGul = div(qGur,qGul);
qGur__qGul = dif(qGur,qGul);
qGur___qGul = dif2(qGur_qGul);
r = [mGur qGur mGul qGul mMagD qMagD mDirD qDirD mGur_mGul mGur__mGul mGur___mGul qGur_qGul qGur__qGul qGur___qGul];
end