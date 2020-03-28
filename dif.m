function d = dif(a, b)
[~,s] = size(a);
d = zeros(1,s*2);
j = 1;
for i=1:s
    d(j)   = a(i)-b(i);
    d(j+1) = b(i)-a(i);
    j      = j+2;
end
end
