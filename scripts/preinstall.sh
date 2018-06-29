#!/bin/bash

#VARS
URL=$(curl https://www.terraform.io/downloads.html | grep _linux_amd64.zip | awk -F '"' '{print $2}')
ARCHIVE=$(curl https://www.terraform.io/downloads.html | grep _linux_amd64.zip | awk -F '"' '{print $2}' | awk -F '/' '{print $6}')


yum remove docker* -y
yum install -y yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y
yum install docker-ce-17.09.1.ce-1.el7.centos -y
systemctl start docker
systemctl enable docker
#docker run hello-world
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable

#Update /etc/hosts
echo $(ip a | grep ens | grep inet | awk '{print $2}' | awk -F '/' '{print $1}') $HOSTNAME >> /etc/hosts

#Install terrform
yum install wget unzip -y
wget $URL
unzip $ARCHIVE
mv terraform /bin/

rm -f $ARCHIVE
