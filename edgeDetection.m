function [meanGv, meanGh] = edgeDetection(block, method)
[~, ~, Gv, Gh] = edge(block, method);
Gv = abs(Gv);
Gh = abs(Gh);
meanGv = mean2(Gv);
meanGh = mean2(Gh);
end