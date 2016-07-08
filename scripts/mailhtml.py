import smtplib
from email.mime.text import MIMEText
HOST='smtp.sina.com.cn'
FROMwho='yineng999@sina.com'
Towhom='nengyi@cn.ibm.com'
SUBJECT='数据报表'
msg=MIMEText("""
<table width="800" border="0" cellspacing="0" cellpadding="4">
<tr>
<td bgcolor="#CECFAD" height="20" style="font-size:14px">*官网数据 <ahref="monitor.domain.com">更多>></a></td>
</tr>
<tr>
<td bgcolor="#EFEBDE" height="100" style="font-size:13px">
1)日访问量：<font color=red>152433</font> 访问次数：23651<br>
2)状态信息<br>
3)访客信息<br>
&nbsp;&nbsp;IE:50% firefox:10% chrome:30%<br>
4)页面信息<br>
&nbsp;&nbsp;/index.php 42153<br>
&nbsp;&nbsp;/view.php 34122<br>
&nbsp;&nbsp;/login.php 34343<br>
</td>
</tr>
</table>""","html","utf-8")
msg['Subject']=SUBJECT
msg['From']=FROMwho
msg['To']=Towhom
server=smtplib.SMTP()
server.connect(HOST,'25')
server.login('yineng999@sina.com','*******')
server.sendmail(FROMwho,Towhom,msg.as_string())
server.quit()
