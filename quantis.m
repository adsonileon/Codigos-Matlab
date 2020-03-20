function q = quantis(a)
p = [0.25 0.5 0.75 1];
q = quantile(a,p,'all');
q = q.';
end