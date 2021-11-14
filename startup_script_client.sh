#!/bin/bash

#Настраиваем autofs для автоматического подключения к ресурсам
dnf -y install autofs
#echo "/mnt  /etc/auto.nfs4 --browse" >> /etc/auto.master
#echo "nfs_share4   -rw,udp        10.0.0.10:/" > /etc/auto.nfs4

echo "/mnt  /etc/auto.nfs3 --browse" >> /etc/auto.master
echo "nfs_share3   -rw,udp        10.0.0.10:/var/nfs_share/" > /etc/auto.nfs3
systemctl restart autofs

#mount -t nfs4  10.0.0.10:/ /mnt/nfs_share4
#mount -o vers=3,proto=udp  10.0.0.10:/var/nfs_share/ /mnt/nfs_share3