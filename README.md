# Домашняя работа №5 курса Otus Linux.Professional  
## NFS, FUSE

- Vagrantfile создает две виртуальные машины: 
    - data_server:
        - При создании применяется скрипт startup_script_client.sh, который:  
          Создает папку /var/nfs_share/upload  
          Дает права на запись /var/nfs_share/upload  
          Публикует на /var/nfs_share для доступа через NFSv4  
    - data_client:  
        - При создании применяется скрипт startup_script_client.sh, который:  
          Настраивает autofs для автоматического монтирования доступных ресурсов на виртуальной машине data_server в /mnt/nfs_share4  