#!/bin/bash
path="/etc/guacamole/"
hostname=$1
port=$2
passwd=$3
protocol=$4
action=$5
if [ -z $hostname ] || [ -z $port ] || [ -z $passwd ] || [ -z $protocol ] || [ -z $action ]
then
         echo "Ban phai nhap day du thong tin hostname,port,pass theo thu tu ke tren "
          exit
fi
connection_name="$protocol"_node_"$hostname"
if [ $action -eq 0 ]
then

 ###INSERT NODE

xmlstarlet ed -s "/user-mapping/authorize" -t elem -n "connection" "$path"user-mapping.xml > "$path"user-mapping.tmp1
xmlstarlet ed -s "/user-mapping/authorize/connection[not(@name)]" -t attr -n "name" -v "$connection_name" "$path"user-mapping.tmp1 > "$path"user-mapping.tmp2
xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']" -t elem -n "protocol" -v "$protocol" "$path"user-mapping.tmp2 > "$path"user-mapping.tmp3
xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']" -t elem -n "param" -v "$hostname" "$path"user-mapping.tmp3 > "$path"user-mapping.tmp4
xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']/param[not(@name)]" -t attr -n "name" -v "hostname" "$path"user-mapping.tmp4 > "$path"user-mapping.tmp5

xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']" -t elem -n "param" -v "$port" "$path"user-mapping.tmp5 > "$path"user-mapping.tmp6
xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']/param[not(@name)]" -t attr -n "name" -v "port" "$path"user-mapping.tmp6 > "$path"user-mapping.tmp7

xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']" -t elem -n "param" -v "$passwd" "$path"user-mapping.tmp7 > "$path"user-mapping.tmp8
xmlstarlet ed -s "/user-mapping/authorize/connection[@name='$connection_name']/param[not(@name)]" -t attr -n "name" -v "password" "$path"user-mapping.tmp8 > "$path"user-mapping.tmp9
mv "$path"user-mapping.xml "$path"user-mapping.tmp10
mv "$path"user-mapping.tmp9 "$path"user-mapping.xml
rm -f "$path"user-mapping.tmp*
fi

if [ $action -eq 1 ]
then
 ###DELETE NODE

 xmlstarlet ed -d "/user-mapping/authorize/connection[@name='$connection_name']" "$path"user-mapping.xml > "$path"user-mapping.tmp1
 mv "$path"user-mapping.xml "$path"user-mapping.tmp2
 mv "$path"user-mapping.tmp1 "$path"user-mapping.xml
 rm -f "$path"user-mapping.tmp2
fi

