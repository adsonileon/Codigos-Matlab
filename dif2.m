function d = dif2(a)
[~,s] = size(a);
d = zeros(1,s);
j = 1;
for i=1:2:s
    d(j)   = a(i)-a(i+1);
    d(j+1) = a(i+1)-a(i);
    j      = j + 2;
end
end