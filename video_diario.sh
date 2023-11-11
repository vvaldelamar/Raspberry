#!/bin/bash
#scripts generación de video media noche
cd /media/pi/DATOS/video_web

#PUERTA_PEATONAL
#/media/pi/DATOS/DATOS-b/9F05661PAG445ED/
find /media/pi/DATOS/DATOS-b/PUERTA_PEATONAL/`date "+%Y-%m-%2d" --date "-1 day"`/001/jpg/ -name "*.jpg" -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n |awk '{print "file "$11}' > image_dahua_01.txt
ffmpeg -y -r 1 -f concat -safe 0 -i image_dahua_01.txt -vcodec h264 -vf "fps=20,scale=-1:720,format=yuv420p,setpts=0.25*PTS" output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.mp4
ffmpeg -y -i output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.mp4 -hls_time 2 -hls_key_info_file /media/pi/DATOS/enc.keyinfo -hls_playlist_type vod -hls_segment_filename "output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`_%d.ts" output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.m3u8
/media/pi/DATOS/spritevideo -i output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.mp4 -o /media/pi/DATOS/video_web -p output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.jpg
ffmpeg -y -i output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.mp4 -r 1 -ss 5 -vframes 1 -s 272x153 output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`_thumb.jpg
rm -rf output_dahua_01_`date "+%Y%m%2d" --date "-1 day"`.mp4
rm -rf image_dahua_01.txt

#PUERTA DE ENTRADA
# /media/pi/DATOS/DATOS-b/9F05661PAGB373F
find /media/pi/DATOS/DATOS-b/9F05661PAGB373F/`date "+%Y-%m-%2d" --date "-1 day"`/001/jpg/ -name "*.jpg" -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n |awk '{print "file "$11}' >image_dahua_02.txt
ffmpeg -y -r 1 -f concat -safe 0 -i image_dahua_02.txt -vcodec h264 -vf "fps=20,scale=-1:720,format=yuv420p,setpts=0.25*PTS" output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.mp4
ffmpeg -y -i output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.mp4 -hls_time 2 -hls_key_info_file /media/pi/DATOS/enc.keyinfo -hls_playlist_type vod -hls_segment_filename "output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`_%d.ts" output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.m3u8
/media/pi/DATOS/spritevideo -i output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.mp4 -o /media/pi/DATOS/video_web -p output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.jpg
ffmpeg -y -i output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.mp4 -r 1 -ss 5 -vframes 1 -s 272x153 output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`_thumb.jpg
rm -rf output_dahua_02_`date "+%Y%m%2d" --date "-1 day"`.mp4
rm -rf image_dahua_02.txt

#rsync -avz /media/pi/DATOS/video_web/ pagos@172.81.60.199:/config/app/santaanita/video
#rsync -avz --exclude=*.mp4 /media/pi/DATOS/video_web/ pagos@172.81.60.199:/config/app/santaanita/video
rsync -avz --exclude=*.mp4 /media/pi/DATOS/video_web/ root@172.81.60.199:/var/lib/rancher/k3s/storage/pvc-c0d3d6ac-3284-425b-af2a-0b8d68573d42_pro_condominio-files-pro/santaanita/video/
