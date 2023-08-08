iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

#.55 frente calle
#.3 frente jadin
#.155 puerta salida
#.4 puerta de entrad
#.1 antena
#acceso panel zkteko control de puertas
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8093 -j DNAT --to-destination 192.168.0.201:4370
#acceso web
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8082 -j DNAT --to-destination 192.168.0.55:80
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8083 -j DNAT --to-destination 192.168.0.4:80
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8084 -j DNAT --to-destination 192.168.0.155:80
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8085 -j DNAT --to-destination 192.168.0.108:80
#ANTENA
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 1443 -j DNAT --to-destination 192.168.0.1:443
#acceso camara
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 554 -j DNAT --to-destination 192.168.0.55:554
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 556 -j DNAT --to-destination 192.168.0.4:554
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 557 -j DNAT --to-destination 192.168.0.155:554
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 558 -j DNAT --to-destination 192.168.0.108:554
#acceso SMART PSS
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 30001 -j DNAT --to-destination 192.168.0.55:37777
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 30002 -j DNAT --to-destination 192.168.0.4:37777
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 30003 -j DNAT --to-destination 192.168.0.108:37777
iptables -t nat -A POSTROUTING -j MASQUERADE
#reglas linsis
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 771 -j DNAT --to-destination 192.168.1.201:443
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 111 -j DNAT --to-destination 192.168.1.65:3389
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 1660 -j DNAT --to-destination 192.168.1.80:1660
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 1650 -j DNAT --to-destination 192.168.1.75:1650
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8443 -j DNAT --to-destination 192.168.1.1:80
#iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 3389 -j DNAT --to-destination 192.168.1.65:3389
echo 1 > /proc/sys/net/ipv4/ip_forward
