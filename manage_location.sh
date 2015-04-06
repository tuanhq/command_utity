#!/bin/bash
node=$1
group=$2
action=$3
dir_bk="/etc/nginx/bk_conf/"
dir_path="/etc/nginx/sites-available/"
if [ ! -d $dir_bk ]
then
  mkdir -p $dir_bk
fi

file_bk="default."`date +%Y_%m_%d_%H_%M_%S`
cp "$dir_path"default "$dir_bk""$file_bk"

if [ -z $node ] || [ -z $group ] || [ -z $action ]
then
        echo 'not enough param: param 1= node ip param 2= nodeName param3 action '
        exit
fi

if [ $action -eq 0 ]
        then
        #########ADDCONNECTION
        line1=`grep -n "###NODE_$group" "$dir_path"default |awk -F ':' '{print$1}'`
        if [ -z $line1 ]
        then
          add_content="###NODE_$group\n\tlocation /$group/guacamole/ {\n\t\tproxy_pass\t\thttp://$node:8081/guacamole/;\n\t\tproxy_http_version 1.1;\n\t\tproxy_set_header Upgrade \$http_upgrade;\n\t\tproxy_set_header Connection \"Upgrade\";\n\t\tproxy_set_header\t\tHost \$host;\n\t\tproxy_set_header\t\tX-Real-IP \$remote_addr;\n\t\tproxy_set_header\t\tX-Forwarded-For \$proxy_add_x_forwarded_for;\n\t\tproxy_connect_timeout\t\t150;\n\t\tproxy_send_timeout\t\t100;\n\t\tproxy_read_timeout\t\t100;\n\t\tproxy_buffers\t\t\t\t4 32k;\n\t\tclient_max_body_size\t\t8m;\n\t\tclient_body_buffer_size\t\t128k;\n }\n\tlocation /$group/jenkins/ {\n\t\tproxy_pass\t\thttp://$node:8080/$group/jenkins/;\n\t\tproxy_set_header\t\tHost \$host;\n\t\tproxy_set_header\t\tX-Real-IP \$remote_addr;\n\t\tproxy_set_header\t\tX-Forwarded-For \$proxy_add_x_forwarded_for;\n\t\tproxy_connect_timeout\t\t150;\n\t\tproxy_send_timeout\t\t100;\n\t\tproxy_read_timeout\t\t100;\n\t\tproxy_buffers\t\t4 32k;\n\t\tclient_max_body_size\t\t8m;\n\t\tclient_body_buffer_size\t\t128k;\n }\n###END_$group"

          sed "/###DANH_DAU###/i $add_content" "$dir_path"default > "$dir_path"default.tmp1
          mv "$dir_path"default.tmp1 "$dir_path"default
        fi
fi
if [ $action -eq 1 ]
        then
        line1=`grep -n "###NODE_$group" "$dir_path"default |awk -F ':' '{print$1}'`
        line2=`grep -n "###END_$group" "$dir_path"default |awk -F ':' '{print$1}'`
        if [ -z $line1 ] || [ -z $line2 ]
        then
          echo 'not found group'
          exit
        fi
        line2=$line2"d"
        sed -e "$line1,$line2" "$dir_path"default > "$dir_path"default.tmp1
        mv "$dir_path"default.tmp1 "$dir_path"default
fi

