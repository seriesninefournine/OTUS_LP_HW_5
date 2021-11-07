#!/bin/bash

#Создаем директории, которые будем расширивать
mkdir -p /var/nfs_share/upload
chmod 777 /var/nfs_share/upload/

#Настраиваем NSFv4 сервер
dnf -y install nfs-utils

systemctl mask --now rpc-statd.service rpcbind.service rpcbind.socket
sed -i -e 's/# vers2=n/vers2=n/g' /etc/nfs.conf
sed -i -e 's/# vers3=y/vers3=n/g' /etc/nfs.conf
echo 'SECURE_NFS="yes"' >> /etc/nfs.conf
systemctl enable --now nfs-server

#Публикуем ресурсы
echo "/var/nfs_share/       *(sync,rw,fsid=0,insecure,no_subtree_check)  
/var/nfs_share/upload/ *(sync,rw,nohide,insecure,no_subtree_check)" > /etc/exports

exportfs -ra

#Настриваем firewalld
systemctl enable --now firewalld
firewall-cmd --permanent --add-service={nfs,nfs3,ssh,mountd}
#firewall-cmd --add-service={rpc-bind,nfs,nfs3,ssh}
firewall-cmd --reload