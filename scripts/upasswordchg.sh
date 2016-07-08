#!/bin/bash
loglist=`grep 'password changed' /var/log/secure | awk '{print $NF"|"$1"-"$2"-"$3}'`
host=`hostname`
ipaddress=`ifconfig eth2 | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'`
[ ! -f /tmp/contentmail ] && touch /tmp/contentmail
for eachlog in $loglist
do
user=`echo $eachlog | awk -F'|' '{print $1}'`
time=`echo $eachlog | awk -F'|' '{print $2}'`
logappear=`grep "$time" /tmp/contentmail | wc -l`
if [ $logappear -eq 0 ];then
echo "Password changed for user $user at $time on server $ipaddress $host" >> /tmp/contentmail
fi
done
content=`cat /tmp/contentmail`
function mailformat(){
cat << eof
Hello Admin!

$content

**************************************************************************************
Please do not reply to this message as it was sent automatically by a service machine. 
Thanks!
**************************************************************************************
AICS team    
**************************************************************************************
eof
}
if [ $logappear -eq 0 ];then
mailformat | mail -s 'User password changed' nengyi@cn.ibm.com
fi
