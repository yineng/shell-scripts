oscheck6=`/bin/uname -r | grep el6.x86_64 | wc -l`
oscheck7=`/bin/uname -r | grep el7.x86_64 | wc -l`
oscheck5=`/bin/uname -r | grep el5.x86_64 | wc -l`
oscheck64=`/bin/uname -r | grep x86_64 | wc -l`
read -p 'Please input server name for dsm:' dsmopt_servername
read -p 'Please input server ip for dsm:' dsmsys_ip

function dsmsys_config() {
cat << eof
SErvername $dsmopt_servername
COMMMethod TCPip
TCPPort 1500
TCPServeraddress $dsmsys_ip
passwordaccess generate
passworddir /opt/tivoli/tsm/client/ba/PASSWD
nodename uniqid_hostname
inclexcl /opt/tivoli/tsm/client/ba/inclexcl.txt
eof
} 

function clexcl_config() {
cat << eof
* INCLEXCL (Include-exclude options file for TSM)
exclude /.../core
exclude /var/tmp/.../*
exclude /var/cache
exclude /opt/tivoli/tsm/client/ba/log/.../*
exclude /etc/backups/logs/*.tmp
exclude.dir /tmp
exclude.dir /scratch
exclude.dir /mnt
exclude.fs /perfdata
exclude.fs /install
exclude.fs /dst/perfdata
exclude.fs /dst/install
eof
}

echo '----------------------The client installation will be started now!!!------------------'
sleep 2

if [ -f 6.4.3.0-TIV-TSMBAC-LinuxX86.tar ];then
echo 'The package is already existed'
else
[ $oscheck6 -eq 1 ] && wget ftp://ftp.software.ibm.com/storage/tivoli-storage-management/maintenance/client/v6r4/Linux/LinuxX86/BA/v643/6.4.3.0-TIV-TSMBAC-LinuxX86.tar
fi

if [ -f 7.1.6.2-TIV-TSMBAC-LinuxX86.tar ];then
echo 'The package is already existed'
else
[ $oscheck7 -eq 1 ] && wget ftp://ftp.software.ibm.com/storage/tivoli-storage-management/maintenance/client/v7r1/Linux/LinuxX86/BA/v716/7.1.6.2-TIV-TSMBAC-LinuxX86.tar
fi


if [ $oscheck5 -eq 1 ];then
echo 'The script can't be executed on Redhat 5 !!!' && exit
fi
if [ $oscheck64 -eq 1 ];then
echo 'The script can't be executed on 32 bit system !!!' && exit
fi

sleep 1
echo '-----------------------Checking package confict!!!------------------------------------'
sleep 1

for eachpackage in TIVsm-API64.*i586 TIVsm-BA.*i586 TIVsm-API.*i586 
do
rpm -qa | grep $eachpackage | xargs rpm -e
done

if [ $oscheck6 -eq 1 ];then
[ -f 6.4.3.0-TIV-TSMBAC-LinuxX86.tar ] && tar -xvf 6.4.3.0-TIV-TSMBAC-LinuxX86.tar
rpm -ivh gskcrypt64-8.0.14.43.linux.x86_64.rpm gskssl64-8.0.14.43.linux.x86_64.rpm 
rpm -ivh TIVsm-API64.x86_64.rpm TIVsm-BA.x86_64.rpm
[ -f /opt/tivoli/tsm/client/ba/bin/dsm.opt.smp ] && cp /opt/tivoli/tsm/client/ba/bin/dsm.opt.smp /opt/tivoli/tsm/client/ba/bin/dsm.opt
[ -f /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp ] && cp /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp /opt/tivoli/tsm/client/ba/bin/dsm.sys
echo "SErvername $dsmopt_servername" >> /opt/tivoli/tsm/client/ba/bin/dsm.opt
sed -i 's/^/*/' /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp /opt/tivoli/tsm/client/ba/bin/dsm.sys
[ -f /opt/tivoli/tsm/client/ba/inclexcl.txt ] || touch /opt/tivoli/tsm/client/ba/inclexcl.txt
dsmsys_config >> /opt/tivoli/tsm/client/ba/bin/dsm.sys
clexcl_config >> /opt/tivoli/tsm/client/ba/inclexcl.txt
echo '-----------------------The client installation completed!!!------------------------'
fi

if [ $oscheck7 -eq 1 ];then
[ -f 7.1.6.2-TIV-TSMBAC-LinuxX86.tar ] && tar -xvf 7.1.6.2-TIV-TSMBAC-LinuxX86.tar
cd bacli
rpm -ivh gskcrypt64-8.0.50.66.linux.x86_64.rpm gskssl64-8.0.50.66.linux.x86_64.rpm 
rpm -ivh TIVsm-API64.x86_64.rpm TIVsm-BA.x86_64.rpm
[ -f /opt/tivoli/tsm/client/ba/bin/dsm.opt.smp ] && cp /opt/tivoli/tsm/client/ba/bin/dsm.opt.smp /opt/tivoli/tsm/client/ba/bin/dsm.opt
[ -f /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp ] && cp /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp /opt/tivoli/tsm/client/ba/bin/dsm.sys
echo "SErvername $dsmopt_servername" >> /opt/tivoli/tsm/client/ba/bin/dsm.opt
sed -i 's/^/*/' /opt/tivoli/tsm/client/ba/bin/dsm.sys.smp /opt/tivoli/tsm/client/ba/bin/dsm.sys
[ -f /opt/tivoli/tsm/client/ba/inclexcl.txt ] || touch /opt/tivoli/tsm/client/ba/inclexcl.txt
dsmsys_config >> /opt/tivoli/tsm/client/ba/bin/dsm.sys
clexcl_config >> /opt/tivoli/tsm/client/ba/inclexcl.txt
echo '-----------------------The client installation completed!!!------------------------'
fi

sleep 2 && echo '-----------------------The backup script will be performed!!!----------------------- '
[ -f DSTBackups_2.0.6.UNIXONLY.tar.gz ] || wget ftp://dst.lexington.ibm.com/pub/DSTBackups/DSTBackups_2.0.6.UNIXONLY.tar.gz
tar -zxvf DSTBackups_2.0.6.UNIXONLY.tar.gz
cp -r backups /etc/
cd /etc/backups
[ -f backupEnv.sh ] && rm -rf backupEnv.sh
cp /etc/backups/SAMPLES/backupEnv.UNIX.sh /etc/backups/backupEnv.sh
chmod 755 /etc/backups/backupEnv.sh
echo 'Please select which you need to backup!'
select backup_option in 'TSM' 'TSM:TDP' 'TDP:notes' 'DB2:db2inst1:OFFLINE' 'DB2:db2inst1:ONLINE' 'DB2:db2inst1:OFFLINE:xyz:ONLINE:zyx'
do
case $backup_option in 
TSM)
echo 'The default is TSM'
break
;;
TSM:TDP)
sed -i '/TSM Only/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/TSM TDP:notes/s/^#//' /etc/backups/backupEnv.sh
break
;;
TDP:notes)
sed -i '/TSM Only/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/BACKUPS-"TDP:notes/s/^#//' /etc/backups/backupEnv.sh
break
;;
DB2:db2inst1:OFFLINE)
sed -i '/TSM Only/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/DB2:db2inst1:OFFLINE:\*/s/^#//' /etc/backups/backupEnv.sh
break
;;
DB2:db2inst1:ONLINE)
sed -i '/TSM Only/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/BACKUPS-"DB2:db2inst1:ONLINE/s/^#//' /etc/backups/backupEnv.sh
break
;;
DB2:db2inst1:OFFLINE:xyz:ONLINE:zyx)
sed -i '/TSM Only/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/OFFLINE:xyz:ONLINE:zyx/s/^#//' /etc/backups/backupEnv.sh
break
;;
esac
done

function site_select() {
sed -i "/$1/s/^#  //" /etc/backups/backupEnv.sh	
}
sleep 1
select site_option in 'DSTAtlanta' 'DSTAustralia' 'DSTAustin' 'DSTBoulder' 'DSTBrazil' 'DSTCanada' 'DSTCommercial' 'DSTChina' 'DSTCloud' 'CustomerHosted' 'DSTDenmark' 'DSTzLinux' 'DSTFrance' 'DSTFishkill' 'DSTIndia' 'ITD' 'DSTLexington' 'DSTMarkham' 'DSTMOP' 'SDSTMexico' 'DSTNetherlands' 'DSTOther' 'DSTPhilippines' 'DSTRaleigh' 'DSTSouthbury' 'DSTWaltham' 'DSTGB' 'DSTPoughkeepsie'
do
site_select $site_option
break
done
sed -i '/TSMMODE:-SCHEDULED/s/^/#/' /etc/backups/backupEnv.sh
sed -i '/TSMMODE:-MANUAL/s/^#//' /etc/backups/backupEnv.sh
sleep 1
echo '------------------------The backup script competed!!!---------------------------'


















