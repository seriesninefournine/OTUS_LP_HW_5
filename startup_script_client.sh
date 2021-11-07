#!/bin/bash

#Настраиваем autofs для автоматического подключения к ресурсам
dnf -y install autofs
echo "/mnt  /etc/auto.nfs4 --browse" >> /etc/auto.master
echo "nfs_share4   -rw        10.0.0.10:/" > /etc/auto.nfs4
systemctl restart autofs

#mount -t nfs4  10.0.0.10:/ /mnt/nfs_share4
