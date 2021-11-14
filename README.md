# Домашняя работа №5 курса Otus Linux.Professional  
## NFS, FUSE

- Vagrantfile создает две виртуальные машины: 
    - data_server:
        - При создании применяется скрипт startup_script_server.sh, который:  
          Отключает версию протокола NFSv2  
          Включает работу протокола NFSv3 по UDP
          Создает папку /var/nfs_share/upload  
          Дает права на запись /var/nfs_share/upload  
          Публикует на /var/nfs_share для доступа через NFSv3
          Открывает необходимые порты в фаерволе  
    - data_client:  
        - При создании применяется скрипт startup_script_client.sh, который:  
          Настраивает autofs для автоматического монтирования доступных ресурсов на виртуальной машине data_server в /mnt/nfs_share3  