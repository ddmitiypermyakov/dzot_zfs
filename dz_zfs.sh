#vagrant box add CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box --name centos2004

##############################################
##Определение алгоритма с наилучшим сжатием###
##############################################
lsblk
sudo -i
#создаем 4 пула из 2 дисков в RAID 1

zpool create otus1 mirror /dev/sb{b,c}
zpool create otus2 mirror /dev/sd{d,e}
zpool create otus3 mirror /dev/sd{f,g}
zpool create otus4 mirror /dev/sd{h,i}

#Информация по пулам

zpool list

#Информация о каждом диске

zpool status

#Добавим разные алгоритмы сжатия в каждую файловую систему:
zfs set compression=lzjb otus1 #Алгоритм lzjb
zfs set compression=lz4 otus2 #Алгоритм lz4
zfs set compression=gzip-9 otus3 #Алгоритм gzip
zfs set compression=zle otus4 #Алгоритм zle

#Проверим, что все файловые системы имеют разные методы сжатия
zfs get all | grep compression

#Скачаем один и тот же текстовый файл во все пулы

for i in {1..4}; do wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done

ls -l /otus*

#/otus1:
#total 22080
#drwxr-xr-x.  2 root root        3 Apr  3 19:48 .
#dr-xr-xr-x. 22 root root     4096 Apr  3 19:37 ..
#-rw-r--r--.  1 root root 41034307 Apr  2 07:54 pg2600.converter.log

#/otus2:
#total 18001
#drwxr-xr-x.  2 root root        3 Apr  3 19:47 .
#dr-xr-xr-x. 22 root root     4096 Apr  3 19:37 ..
#-rw-r--r--.  1 root root 41034307 Apr  2 07:54 pg2600.converter.log

#/otus3:
#total 10966
#drwxr-xr-x.  2 root root        3 Apr  3 19:47 .
#dr-xr-xr-x. 22 root root     4096 Apr  3 19:37 ..
#-rw-r--r--.  1 root root 41034307 Apr  2 07:54 pg2600.converter.log

#/otus4:
#total 40105
#drwxr-xr-x.  2 root root        3 Apr  3 19:48 .
#dr-xr-xr-x. 22 root root     4096 Apr  3 19:37 ..
#-rw-r--r--.  1 root root 41034307 Apr  2 07:54 pg2600.converter.log

zfs list

zfs get all | grep compressratio | grep -v ref
#otus1  compressratio         1.80x                  -     #Алгоритм lzjb 
#otus2  compressratio         2.21x                  - #Алгоритм lz4
#otus3  compressratio         3.63x                  -  #Алгоритм gzip
#otus4  compressratio         1.00x                  -#Алгоритм zle


##############################################
#Алгоритм gzip cамый мощный алгоритм сжатия###
##############################################

########################################
######Определить настройки пула#########
########################################


#Скачиваем архив

wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'

#Разархивируем 
tar -xzvf archive.tar.gz

#zpoolexport/
#zpoolexport/filea
#zpoolexport/fileb


#Проверим, возможно ли импортировать данный каталог в пул:

zpool import -d zpoolexport/

#pool: otus
#     id: 6554193320433390805
#  state: ONLINE
# action: The pool can be imported using its name or numeric identifier.
# config:

#       otus                         ONLINE
#         mirror-0                   ONLINE
#           /root/zpoolexport/filea  ONLINE
#           /root/zpoolexport/fileb  ONLINE

zpool status

#errors: No known data errors



#пул с именем otus поменяем на newotus при импорте 
zpool import -d zpoolexport/ otus newotus

#Определение настроек
#Все настройки

zpool get all newotus
#Размер: 
zfs get available newotus

#Тип: 
zfs get readonly newotus

#Значение recordsize: 
zfs get recordsize newotus

#Тип сжатия (или параметр отключения): 
zfs get compression newotus

#Тип контрольной суммы: 
zfs get checksum newotus


########################################
##Рассмотрены параметры ################
########################################

##########################################################
##Работа со снапшотом, поиск сообщения от преподавателя###
##########################################################


#Скачаем файл, указанный в задании
wget -O otus_task3.file --no-check-certificate https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download

#Восстановим файловую систему из снапшота:

zfs receive /home/vagrant/newotus/test@today < otus_task3.file

#ищем в каталоге /otus/test файл с именем “secret_message”:

find /newotus/test -name "secret_message"

#/newotus/test/task1/file_mess/secret_message

cat /newotus/test/task1/file_mess/secret_message

#https://otus.ru/lessons/linux-hl/


echo "#######################################"
echo "###задание выполнено###################"
echo "#######################################"