import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage

Host='smtp.sina.com.cn'
FromWho='yineng999@sina.com'
ToWhom='nengyi@cn.ibm.com'
SUBJECT='图片测试邮件'

def addimg(src,imgid):
    fp=open(src,'rb')
    msgImage=MIMEImage(fp.read())
    fp.close()
    msgImage.add_header('Contend-ID',imgid)
    return(msgImage)
msg=MIMEMultipart('related')
msgtext=MIMEText("""
<table width="600" border="0" cellspace="0" cellpadding="4">
<tr bgcolor="#CECFAD" height="20" style="font-size:14px">
<td colspan=2>*图片测试 <a href="守望先锋">更多>></a></td>
</tr>
<tr bgcolor="#EFEBDE" height="100" style="font-size=13px">
<td>
<img src="cid:sisheng"></td><td>
<img src="cid:shanguang"></td><td>
</tr>
</table>""","html","utf-8")
msg.attach(msgtext)
msg.attach(addimg("sishen.jpg","sisheng"))
msg.attach(addimg("shanguang.jpg","shanguang"))
msg['Subject']=SUBJECT
msg['From']=FromWho
msg['To']=ToWhom
server=smtplib.SMTP()
server.connect(Host,'25')
server.login('yineng999@sina.com','******')
server.sendmail(FromWho,ToWhom,msg.as_string())
server.quit()
