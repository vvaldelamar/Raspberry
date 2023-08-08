#!/bin/bash
# scripts generación de video media noche
# Imprimimos la fecha en cada foto
#identify -format "%w x %h %Q\n" DATOS-b/01/192.168.0.155_01_20230805141057093_MOTION_DETECTION.jpg

path="/media/pi/DATOS/DATOS-b/HILOOK/`date "+%Y%m%2d" --date "-1 day"`/"
find "$path" -name "*.jpg" -type f | while read -r filename; do
    datetime=$(echo "$filename" | grep -oP '\d{4}\d{2}\d{2}\d{6}')
    date="${datetime:6:2}-${datetime:4:2}-${datetime:0:4}"
    time="${datetime:8:2}:${datetime:10:2}:${datetime:12:2}"
    mogrify -gravity NorthEast -pointsize 30 -fill white -annotate +100+30 "$date $time" "$filename"
    #Regresa la fecha y hora para el orden del grabado del video.
    original_datetime=$(stat -c %y "$filename")
    formatted_datetime=$(date -d "$original_datetime" "+%Y%m%d%H%M.%S")
    touch -m -t "$formatted_datetime" "$filename"	
done
cd /media/pi/DATOS/video_web
find /media/pi/DATOS/DATOS-b/HILOOK/`date "+%Y%m%2d" --date "-1 day"`/ -name "*.jpg" -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n |awk '{print "file "$11}' > image_hilook.txt
#ENTRADA HILOOK
#/media/pi/DATOS/DATOS-b/HILOOK/
ffmpeg -y -r 1 -f concat -safe 0 -i image_hilook.txt -vcodec h264 -vf "fps=20,scale=-1:720,format=yuv420p,setpts=0.25*PTS" output_hilook_`date "+%Y%m%2d" --date "-1 day"`.mp4
ffmpeg -y -i output_hilook_`date "+%Y%m%2d" --date "-1 day"`.mp4 -hls_time 2 -hls_key_info_file /media/pi/DATOS/enc.keyinfo -hls_playlist_type vod -hls_segment_filename "output_hilook_`date "+%Y%m%2d" --date "-1 day"`_%d.ts" output_hilook_`date "+%Y%m%2d" --date "-1 day"`.m3u8
/media/pi/DATOS/spritevideo -i output_hilook_`date "+%Y%m%2d" --date "-1 day"`.mp4 -o /media/pi/DATOS/video_web -p output_hilook_`date "+%Y%m%2d" --date "-1 day"`.jpg
ffmpeg -y -i output_hilook_`date "+%Y%m%2d" --date "-1 day"`.mp4 -r 1 -ss 5 -vframes 1 -s 272x153 output_hilook_`date "+%Y%m%2d" --date "-1 day"`_thumb.jpg
rm -rf output_hilook_`date "+%Y%m%2d" --date "-1 day"`.mp4
rm -rf image_hilook.txt

rsync -avz /media/pi/DATOS/video_web/ pagos@172.81.60.199:/config/app/santaanita/video
