servers="
9.98.13.40
9.98.13.50
"
logintime=`date +%Y-%m-%d`
[ -f /tmp/sshaccesslog.txt ] || touch /tmp/sshaccesslog.txt
for i in $servers
do
ssh -tt -o StrictHostKeyChecking=no PasswordAuthentication=no -i /home/script/shell/nengyi.key dstadmin@$i "echo 123 > /dev/null" &> /dev/null
if [ $? -ne 0 ];then
echo "SSH login failure on server $i at $logintime" >> /tmp/sshaccesslog.txt
fi
done
content=`cat /tmp/sshaccesslog.txt`
function formatsshmail(){
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
formatsshmail | mail -s "登录检查报告" nengyi@cn.ibm.com