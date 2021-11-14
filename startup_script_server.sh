#!/bin/bash

#Создаем директории, которые будем расширивать
mkdir -p /var/nfs_share/upload
chmod 777 /var/nfs_share/upload/

#Настраиваем NSFv4 сервер
dnf -y install nfs-utils

#systemctl mask --now rpc-statd.service rpcbind.service rpcbind.socket
sed -i -e 's/# vers2=n/vers2=n/g' /etc/nfs.conf
sed -i -e 's/# vers3=y/vers3=y/g' /etc/nfs.conf
sed -i -e '/# tcp=y/ a\udp=y' /etc/nfs.conf

# tcp=y
# vers2=n
# vers3=y
# vers4=n
# vers4.0=n
# vers4.1=n
# vers4.2=n

#sed -i -e 's/# vers3=y/vers3=n/g' /etc/nfs.conf
#echo 'SECURE_NFS="yes"' >> /etc/nfs.conf
systemctl enable --now nfs-server

#Публикуем ресурсы
#echo "/var/nfs_share/       *(sync,rw,fsid=0,insecure,no_subtree_check)  
#/var/nfs_share/upload/ *(sync,rw,nohide,insecure,no_subtree_check)" > /etc/exports
echo "/var/nfs_share/ *(sync,rw,insecure,no_subtree_check)" > /etc/exports
exportfs -ra

#Настриваем firewalld
systemctl enable --now firewalld
firewall-cmd --permanent --add-service={nfs,nfs3,ssh,mountd}
firewall-cmd --permanent --add-port=111/udp --add-port=2049/udp
systemctl restart firewalld