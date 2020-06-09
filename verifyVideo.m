function [video,width,height,bitdepth,nframes] = verifyVideo(name)
if strcmp(name,"Dark")
    video = "Dark\Dark_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"Kristen")
    video = "Kristen\KristenAndSara_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
elseif strcmp(name,"Netflix_DrivingPOV")
    video = "Netflix_DrivingPov\Netflix_DrivingPOV_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
else
    video = "Vidyo4\Vidyo4_1280x720p_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    nframes = 120;
end
end