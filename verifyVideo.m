function [video,width,height,bitdepth] = verifyVideo(video_number)
    if video_number == 0
        video = "720p/Dark/Dark_1280x720_60fps_8bit_420_120f.yuv";
        width = 1280;
        height = 720;
        bitdepth = 8;
    elseif video_number == 1
        video = "720p/GipsRestat/gipsrestat720p_120f.yuv";
        width = 1280;
        height = 720;
        bitdepth = 8;
    elseif video_number == 2
        video = "720p/NetflixDinnerScene/Netflix_DinnerScene_1280x720_60fps_8bit_420_120f.yuv";
        width = 1280;
        height = 720;
        bitdepth = 8;
    elseif video_number == 3
        video = "720p/NetflixDrivingPOV/Netflix_DrivingPOV_1280x720_60fps_8bit_420_120f.yuv";
        width = 1280;
        height = 720;
        bitdepth = 8;
    elseif video_number == 4
        video = "720p/Vidyo4/Vidyo4_1280x720_60.yuv";
        width = 1280;
        height = 720;
        bitdepth = 8;
    elseif video_number == 5
        video = "1080p/Beauty/Beauty_1920x1080_120fps_420_8bit_YUV.yuv";
        width = 1920;
        height = 1080;
        bitdepth = 8;
    elseif video_number == 6
        video = "1080p/Jockey/Jockey_1920x1080_120fps_420_8bit.yuv";
        width = 1920;
        height = 1080;
        bitdepth = 8;
    elseif video_number == 7
        video = "1080p/NetflixTunnelFlag/Netflix_TunnelFlag_1920x1080_60fps_8bit_420_60f.yuv";
        width = 1920;
        height = 1080;
        bitdepth = 8;
    elseif video_number == 8
        video = "1080p/Rush/rush_field_cuts_1080p_60f.yuv";
        width = 1920;
        height = 1080;
        bitdepth = 8;
    elseif video_number == 9
        video = "1080p/Touchdown/touchdown_pass_1080p_60f.yuv";
        width = 1920;
        height = 1080;
        bitdepth = 8;
    elseif video_number == 10
        video = "4K/BuildingHall2/BuildingHall2_3840x2160_50fps_10bit_420.yuv";
        width = 3840;
        height = 2160;
        bitdepth = 10;
    elseif video_number == 11
        video = "4K/Lips/Lips_3840x2160_120fps_10bit.yuv";
        width = 3840;
        height = 2160;
        bitdepth = 10;
    elseif video_number == 12
        video = "4K/NetflixDancers/Netflix_Dancers_4096x2160_60fps_10bit_420_60f.yuv";
        width = 4096;
        height = 2160;
        bitdepth = 10;
    elseif video_number == 13
        video = "4K/SunBath/SunBath_3840x2160_50fps_10bit.yuv";
        width = 3840;
        height = 2160;
        bitdepth = 10;
    elseif video_number == 14
        video = "4K/ToddlerFountain/ToddlerFountain_4096x2160_60fps_10bit_420_jvet.yuv";
        width = 4096;
        height = 2160;
        bitdepth = 10;
    else
        error("Número de vídeo inválido: %d", video_number);
    end
end