#!/bin/bash
group=$1
sed "s/PREFIX=\/jenkins/PREFIX=\/$1\/jenkins/g"  /etc/default/jenkins > /etc/default/jenkins.tmp1
mv /etc/default/jenkins /etc/default/jenkins.tmp2
mv /etc/default/jenkins.tmp1 /etc/default/jenkins
rm -f /etc/default/jenkins.tmp2
service jenkins restart

