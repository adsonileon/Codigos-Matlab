function [video,width,height,bitdepth,nframes] = verifyVideo(name)
if strcmp(name,"Dark")
    video = "Treinamento\720p\Dark\Dark_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"Kristen")
    video = "Treinamento\720p\Kristen\KristenAndSara_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"Netflix_DrivingPOV")
    video = "NETVC(AV1)\720p\Netflix_DrivingPov\Netflix_DrivingPOV_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"Vidyo4")
    video = "Treinamento\720p\Vidyo4\Vidyo4_1280x720p_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"C")
    video = "C\RaceHorses_832x480_30fps_8bit_420.yuv";
    width = 832;
    height = 480;
    bitdepth = 8;
    nframes = 300;
elseif strcmp(name,"D")
    video = "D\BQSquare_416x240_60fps_8bit_420.yuv";
    width = 416;
    height = 240;
    bitdepth = 8;
    nframes = 601;
elseif strcmp(name,"E")
    video = "E\Johnny_1280x720_60fps_8bit_420.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 600;
elseif strcmp(name,"F(1)")
    video = "F(1)\SlideEditing_1280x720_30fps_8bit_420.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 300;
elseif strcmp(name,"B")
    video = "B\MarketPlace_1920x1080_60fps_10bit_420.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 10;
    nframes = 600;
end
end