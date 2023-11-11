for i in `find /media/pi/DATOS/DATOS-b/CALLESANC/ -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/SENSORES -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/video_web/ -maxdepth 1 -type f -mtime +3 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/9F05661PAGB373F -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/9F05661PAG445ED -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
