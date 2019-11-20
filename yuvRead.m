function [y, u, v] = yuvRead(fid, width, height, bitDepth)
if bitDepth == 8
    lengthY = strcat(num2str(width*height), "*uint8");
    lengthUV = strcat(num2str(width/2*height/2), "*uint8");
else
    lengthY = strcat(num2str(width*height), "*uint16");
    lengthUV = strcat(num2str(width/2*height/2), "*uint16");    
end
y = uint16(fread(fid, [width height], lengthY));
y = y';
u = uint16(fread(fid, [width/2 height/2], lengthUV));
u = u';
v = uint16(fread(fid, [width/2 height/2], lengthUV));
v = v';
if bitDepth == 8
    y = 4*y;
    u = 4*u;
    v = 4*v;
end
end
