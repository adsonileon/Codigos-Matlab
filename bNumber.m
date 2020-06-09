function number = bNumber(width,height,bw,bh,xtl,ytl,xbr,ybr)
numbers = 1;
number = 0;
for i=1:bh:height
    iEnd = i+bh-1;
    iEnd = min(height, iEnd);
    for j=1:bw:width
        jEnd = j+bw-1;
        jEnd = min(width, jEnd);
        if iEnd-i+1==bh && jEnd-j+1==bw
             if i==ytl+1 && iEnd==ybr+1 && j==xtl+1 && jEnd==xbr+1
                number=numbers;
                return;
             end
            numbers=numbers+1;
        end
    end
end
end