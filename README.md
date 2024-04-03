Описание домашнего задания


1. Определить алгоритм с наилучшим сжатием:
    - Определить какие алгоритмы сжатия поддерживает zfs (gzip, zle, lzjb, lz4);
    - создать 4 файловых системы на каждой применить свой алгоритм сжатия;
    - для сжатия использовать либо текстовый файл, либо группу файлов.
2. Определить настройки пула.
  - С помощью команды zfs import собрать pool ZFS.
  - Командами zfs определить настройки:
    - размер хранилища;
    - тип pool;
    - значение recordsize;
    - какое сжатие используется;
    - какая контрольная сумма используется.
3. Работа со снапшотами:
    - скопировать файл из удаленной директории;
    - восстановить файл локально. zfs receive;
    - найти зашифрованное сообщение в файле secret_message.
1. dz_zfs.sh скрипт по выполнению ДЗ
2. install.sh скрипт по инсталляции zfs, wget
3. Vagrantfile - запуск ВМ
  - Скачать и добавить ВМ с https://app.vagrantup.com/centos/boxes/7
    - P.S. vagrant box add CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box --name centos2004