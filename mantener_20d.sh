for i in `find /media/pi/DATOS/DATOS-b/PUERTA_ENTRADA -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/PUERTA_PEATONAL -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/CALLESANC/ -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/DATOS-b/SENSORES -maxdepth 1 -type d -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
for i in `find /media/pi/DATOS/video_web/ -maxdepth 1 -type f -mtime +5 -print`; do echo -e "Borrando el directorio $i"; rm -rf $i; done
