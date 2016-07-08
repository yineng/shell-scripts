passconvert=`grep '_' sshcredential | wc -l`
if [ $passconvert -eq 0 ];then
sed -i 's/ /_/' sshcredential
fi
for i in `cat sshcredential`
do
ip=`echo $i | awk -F_ '{print $1}'`
password=`echo $i | awk -F_ '{print $2}'`
sshpass -o StrictHostKeyChecking=no -p "$password" ssh "root@$ip" "echo 123 > /dev/null" &>/dev/null
if [ $? -eq 0 ];then
echo $ip ssh login
else
echo $ip ssh failure
fi 
done
