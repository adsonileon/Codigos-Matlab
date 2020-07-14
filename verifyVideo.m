function [video,width,height,bitdepth,skip] = verifyVideo(name)
if strcmp(name,"Dark")
    video = "Treinamento\720p\Dark\Dark_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Kristen")
    video = "Treinamento\720p\Kristen\KristenAndSara_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Netflix_DinnerScene")
    video = "Treinamento\720p\Netflix_DinnerScene\Netflix_DinnerScene_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Netflix_DrivingPOV")
    video = "Treinamento\720p\Netflix_DrivingPov\Netflix_DrivingPOV_1280x720_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Vidyo4")
    video = "Treinamento\720p\Vidyo4\Vidyo4_1280x720p_60fps_8bit_420_120f.yuv";
    width = 1280;
    height = 720;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Beauty")
    video = "Treinamento\1080p\Beauty\Beauty_1920x1080_120fps_420_8bit_YUV.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 8;
    skip = 10;
elseif strcmp(name,"Jockey")
    video = "Treinamento\1080p\Jockey\Jockey_1920x1080_120fps_420_8bit.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 8;
    skip = 10;
elseif strcmp(name,"Netflix_Tunnel")
    video = "Treinamento\1080p\Netflix_Tunnel\Netflix_TunnelFlag_1920x1080_60fps_8bit_420_60f.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Rush")
    video = "Treinamento\1080p\Rush\rush_field_cuts_1080p_60f.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"Touchdown")
    video = "Treinamento\1080p\Touchdown\touchdown_pass_1080p_60f.yuv";
    width = 1920;
    height = 1080;
    bitdepth = 8;
    skip = 1;
elseif strcmp(name,"BuildingHall2")
    video = "Treinamento\4K\BuildingHall2\BuildingHall2_3840x2160_50fps_10bit_420.yuv";
    width = 3840;
    height = 2160;
    bitdepth = 10;
    skip = 16;
elseif strcmp(name,"Lips")
    video = "Treinamento\4K\Lips\Lips_3840x2160_120fps_10bit.yuv";
    width = 3840;
    height = 2160;
    bitdepth = 10;
    skip = 20;
elseif strcmp(name,"Netflix_Dancers")
    video = "Treinamento\4K\Netflix_Dancers\Netflix_Dancers_4096x2160_60fps_10bit_420_60f.yuv";
    width = 4096;
    height = 2160;
    bitdepth = 10;
    skip = 2;
elseif strcmp(name,"SunBath")
    video = "Treinamento\4K\SunBath\SunBath_3840x2160_50fps_10bit.yuv";
    width = 3840;
    height = 2160;
    bitdepth = 10;
    skip = 10;
elseif strcmp(name,"ToddlerFountain")
    video = "Treinamento\4K\ToddlerFountain\ToddlerFountain_4096x2160_60fps_10bit_420_jvet.yuv";
    width = 4096;
    height = 2160;
    bitdepth = 10;
    skip = 10;
end
end