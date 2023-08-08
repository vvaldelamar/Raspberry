#!/bin/bash  
rm -rf /media/pi/DATOS/DATOS-b/01
mkdir /media/pi/DATOS/DATOS-b/HILOOK/`date "+%Y%m%d"`
cd /media/pi/DATOS/DATOS-b
ln -s /media/pi//DATOS/DATOS-b/HILOOK/`date "+%Y%m%d"`/ 01
