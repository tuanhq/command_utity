---CÀI ĐẶT GATE



sudo apt-get update
sudo apt-get upgrade
sudo add-apt-repository ppa:guacamole/stable

## co the list ra tat cac cac phien ban guacamole-tomcat dang co tren ppa bang lenh "apt-cache showpkg guacamole-tomcat" sau do copy vao lenh duoi day
sudo apt-get install guacamole-tomcat
apt-get install libguac-client-ssh0 libguac-client-rdp0
ln -s /var/lib/guacamole/guacamole.war /var/lib/tomcat6/webapps
mkdir -p /usr/share/tomcat6/.guacamole
ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat6/.guacamole/

sudo vim /etc/guacamole/start.sh

#!/bin/bash
/etc/init.d/tomcat6 start
/etc/init.d/guacd start
####END

sudo vim /etc/guacamole/stop.sh

#!/bin/bash
/etc/init.d/guacd stop
/etc/init.d/tomcat6 stop

sudo vim /etc/init.d/guacamole

copy content 
#!/bin/bash
# guacamole
#
# description: service for guacamole

case $1 in
    start)
        /bin/bash /etc/guacamole/start.sh
    ;;
    stop)
        /bin/bash /etc/guacamole/stop.sh
    ;;
    restart)
        /bin/bash /etc/guacamole/stop.sh
        /bin/bash /etc/guacamole/start.sh
    ;;
esac
exit 0



sudo chmod +x /etc/guacamole/*.sh
sudo chmod +x /etc/init.d/guacamole

sudo update-rc.d guacamole defaults 99


--CÀI ĐẶT SERVER REMOVE (UBUNTU)

##user/pass ubuntu/******

sudo apt-get update
sudo apt-get install x11vnc
x11vnc -storepasswd

sudo vim /etc/init/x11vnc.conf

start on login-session-start
script
x11vnc -xkb -noxrecord -noxfixes -noxdamage -repeat -display :0 -auth /var/run/lightdm/root/:0 -forever -shared -bg -o /var/log/x11vnc.log -rfbauth /home/ubuntu/.vnc/passwd -rfbport 5900 -24to32
end script

###################DOI VOI UBUNTU XFCE4

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install gnome-core xfce4 firefox

sudo apt-get install x11vnc
x11vnc -storepasswd

copy xauthory to fix directoy

sudo vim /etc/init/x11vnc.conf

start on login-session-start
script
x11vnc -xkb -noxrecord -noxfixes -noxdamage -repeat -display :0 -auth /var/run/gdm/ubuntu/database -forever -shared -bg -o /var/log/x11vnc.log -rfbauth /home/ubuntu/.vnc/passwd -rfbport 5900 -24to32 -geometry 1024x768
end script

###COMMENT NHAP
start on login-session-start
script
x11vnc -xkb -noxrecord -noxfixes -noxdamage -repeat -display :0 -auth /var/run/lightdm/root/:0 -forever -shared -bg -o /var/log/x11vnc.log -rfbauth /home/tuanhq/.vnc/passwd -rfbport 5900 -24to32 -solid grey -geometry 1920x1080
end script

x11vnc -xkb -noxrecord -noxfixes -noxdamage -repeat -display :0 -auth /var/run/lightdm/root/:0 -forever -shared -bg -o /var/log/x11vnc.log -rfbauth /home/ubuntu/.vnc/passwd -rfbport 5900 -24to32



x11vnc -display :0 -auth /var/run/lightdm/root/:0 -forever -shared -rfbauth /home/ubuntu/.vnc/passwd -rfbport 5900 -usepw

1920x1080
