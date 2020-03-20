function s = sobel(block)
block = double(block);
Gx = [-1 0 1;
      -2 0 2;
      -1 0 1];
Gy = [-1 -2 -1;
       0  0  0;
       1  2  1];
Gv = imfilter(block, Gx, 'replicate');
Gh = imfilter(block, Gy, 'replicate');
mGv = mean2(abs(Gv)); %Média
mGh = mean2(abs(Gh)); %Média
qGv = quantis(abs(Gv));
qGh = quantis(abs(Gh));
[magVH, dirVH] = imgradient(Gv, Gh);
mMagVH = mean2(magVH); %Média
mDirVH = mean2(dirVH); %Média
qMagVH = quantis(magVH);
qDirVH = quantis(dirVH);
Gx = [ 0  1  2;
      -1  0  1;
      -2 -1  0];
Gy = [-2 -1  0;
      -1  0  1;
       0  1  2];
Gur = imfilter(block, Gx, 'replicate');
Gul = imfilter(block, Gy, 'replicate');
mGur = mean2(abs(Gur)); %Média
mGul = mean2(abs(Gul)); %Média
qGur = quantis(abs(Gur));
qGul = quantis(abs(Gul));
[magD, dirD] = imgradient(Gur, Gul);
mMagD = mean2(magD); %Média
mDirD = mean2(dirD); %Média
qMagD = quantis(magD);
qDirD = quantis(dirD);
%Razões
mGh_mGv   = div(mGh,mGv);
qGv_qGh   = div(qGh,qGv);
mGul_mGur = div(mGul,mGur);
qGul_qGur = div(qGul,qGur);
s = [mGv qGv mGh qGh mMagVH qMagVH mDirVH qDirVH mGur qGur mGul qGul mMagD qMagD mDirD qDirD mGh_mGv qGv_qGh mGul_mGur qGul_qGur];
end