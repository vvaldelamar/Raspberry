
#!/bin/bash
#scripts generación de video media noche
cd /media/pi/DATOS/video_web

#CALLE SANCRISTOBAL
# /media/pi/DATOS/DATOS-b/CALLESANC
find /media/pi/DATOS/DATOS-b/CALLESANC/`date "+%Y-%m-%2d" --date "-1 day"`/001/jpg/ -name "*.jpg" -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n |awk '{print "file "$11}' >image_dahua_04.txt
ffmpeg -y -r 1 -f concat -safe 0 -i image_dahua_04.txt -vcodec h264 -vf "fps=20,scale=-1:720,format=yuv420p,setpts=0.25*PTS" output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.mp4
ffmpeg -y -i output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.mp4 -hls_time 2 -hls_key_info_file /media/pi/DATOS/enc.keyinfo -hls_playlist_type vod -hls_segment_filename "output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`_%d.ts" output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.m3u8
/media/pi/DATOS/spritevideo -i output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.mp4 -o /media/pi/DATOS/video_web -p output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.jpg
ffmpeg -y -i output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.mp4 -r 1 -ss 5 -vframes 1 -s 272x153 output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`_thumb.jpg
rm -rf output_dahua_04_`date "+%Y%m%2d" --date "-1 day"`.mp4
rm -rf image_dahua_04.txt

rsync -avz /media/pi/DATOS/video_web/ pagos@172.81.60.199:/config/app/santaanita/video
