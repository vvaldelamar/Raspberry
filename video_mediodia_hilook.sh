#!/bin/bash
#scripts generación de video medio dia
#Se separa de otro porque necesita tratamiento especial esta camara HILOOK caca
cd /media/pi/DATOS/video_web
#ENTRADA HILOOK
#/media/pi/DATOS/DATOS-b/HILOOK/
# Imprimimos la fecha en cada foto
path="/media/pi/DATOS/DATOS-b/HILOOK/`date "+%Y%m%2d"`/"
find "$path" -name "*.jpg" -type f | while read -r filename; do
    datetime=$(echo "$filename" | grep -oP '\d{4}\d{2}\d{2}\d{6}')
    date="${datetime:6:2}-${datetime:4:2}-${datetime:0:4}"
    time="${datetime:8:2}:${datetime:10:2}:${datetime:12:2}"
    #Recupera el horario de los archivos
    original_datetime=$(stat -c %y "$filename")
    formatted_datetime=$(date -d "$original_datetime" "+%Y%m%d%H%M.%S")
    mogrify -gravity NorthEast -pointsize 30 -fill white -annotate +100+30 "$date $time" "$filename"
    touch -m -t "$formatted_datetime" "$filename" 
done

find /media/pi/DATOS/DATOS-b/HILOOK/`date "+%Y%m%2d"`/ -name "*.jpg" -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n |awk '{print "file "$11}' > image_hilook.txt
ffmpeg -y -r 1 -f concat -safe 0 -i image_hilook.txt -vcodec h264 -vf "fps=20,scale=-1:720,format=yuv420p,setpts=0.25*PTS" output_hilook_`date "+%Y%m%2d"`.mp4
ffmpeg -y -i output_hilook_`date "+%Y%m%2d"`.mp4 -hls_time 2 -hls_key_info_file /media/pi/DATOS/enc.keyinfo -hls_playlist_type vod -hls_segment_filename "output_hilook_`date "+%Y%m%2d"`_%d.ts" output_hilook_`date "+%Y%m%2d"`.m3u8
/media/pi/DATOS/spritevideo -i output_hilook_`date "+%Y%m%2d"`.mp4 -o /media/pi/DATOS/video_web -p output_hilook_`date "+%Y%m%2d"`.jpg
ffmpeg -y -i output_hilook_`date "+%Y%m%2d"`.mp4 -r 1 -ss 5 -vframes 1 -s 272x153 output_hilook_`date "+%Y%m%2d"`_thumb.jpg
rm -rf output_hilook_`date "+%Y%m%2d"`.mp4
rm -rf image_hilook.txt

rsync -avz /media/pi/DATOS/video_web/ pagos@172.81.60.199:/config/app/santaanita/video
