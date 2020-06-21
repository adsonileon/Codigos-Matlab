function r = div(a,b)
[~, s] = size(a);
r = zeros(1,s*2);
j = 1;
for i=1:s
%     if b(i) > 0
    r(j) = a(i)/b(i);
%     else
%         r(j) = -1;
%     end
%     if a(i) > 0
    r(j+1) = b(i)/a(i);
%     else
%         r(j+1) = -1;
%     end
    j=j+2;
end
end