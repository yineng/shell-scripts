#coding:utf8
import smtplib
from email.mime.text import MIMEText
HOST='9.98.15.7'
FROMwho='###@###'
Towhom="nengyi@###,caoweiwh@###,zqzouzq@###"
SUBJECT='Action Required - Claim & Hours Plan'
msg=MIMEText("""
<div style="background-color:#ECECEC; padding: 35px;">
    <table cellpadding="0" align="center" style="width: 600px; margin: 0px auto; text-align: left; position: relative; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-right
-radius: 5px; border-bottom-left-radius: 5px; font-size: 14px; font-family:微软雅黑, 黑体; line-height: 1.5; box-shadow: rgb(153, 153, 153) 0px 0px 5px; border-collapse: collapse; background-positi
on: initial initial; background-repeat: initial initial;background:#fff;">
    <tbody>
    <tr>
    <th valign="middle" style="height: 25px; line-height: 25px; padding: 15px 35px; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #082E54; background-color: #191970; bo
rder-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-right-radius: 0px; border-bottom-left-radius: 0px;">
    <font face="微软雅黑" size="5" style="color: rgb(255, 255, 255); ">AICS Reminding</font>
    </th>
    </tr>
    <tr>
    <td>
    <div style="padding:25px 35px 40px; background-color:#fff;">
    <h2 style="margin: 5px 0px; "><font color="#333333" style="line-height: 20px; "><font style="line-height: 22px; " size="4">Dear everyone,</font></font></h2>
    <p>Please submit your hours in ILC for this week.</p>
    <p> Please submit your hours plan in PMP in advance if you take vacation in next week.</p>
    <p> I strongly recommend that you submit your hours in ILC on every Monday morning, the first time when you back to the work for the new week. And update the hours later if you have overtime.
If you haven't claimed when you see this reminded email, please claim at once to avoid the potential missing claim, thanks!    
   <p> Hours Plan Link: https://w3-01.sso.ibm.com/services/tools/marketplace/submitMyHoursPlan.wss</p>
    <p>HRMS Link: https://w3-153.ibm.com/irj/portal</p>
    <p align="right">AICS China</p>
    </div>
    </td>
    </tr>
    </tbody>
    </table>
    </div>""","html","utf-8")
msg['Subject']=SUBJECT
msg['From']=FROMwho
msg['To']=Towhom
server=smtplib.SMTP()
server.connect(HOST,'25')
server.sendmail(FROMwho,["nengyi@###","caoweiwh@###","zqzouzq@###"],msg.as_string())
server.quit()
