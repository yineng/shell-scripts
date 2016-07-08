import smtplib
import string
import os
Host='smtp.sina.com.cn'
SUBJECT='Mail from Python'
ToWhom='nengyi@cn.ibm.com'
FROMWho='yineng999@sina.com'
content='The fisrt mail from Python!'
BODY="""From: yineng999@sina.com
To: nengyi@cn.ibm.com
Subject: Mail from Python

The fisrt mail from Python!
"""
#BODY='/r/n'.join(("From: %s" % FROMWho,"To: %s" % ToWhom,"Subject: %s" % SUBJECT,"",content ))
#BODY=string.join(("From: %s" % FROMWho,"To: %s" % ToWhom,"Subject: %s" % SUBJECT,"",content ),"/r/n")
#BODY=os.path.join(("From: %s" % FROMWho,"To: %s" % ToWhom,"Subject: %s" % SUBJECT,"",content ),"/r/n")
Mailstart=smtplib.SMTP()
Mailstart.connect(Host,'25')
#Mailstart.starttls()
Mailstart.login('yineng999@sina.com','jy02308944')
Mailstart.sendmail(FROMWho,[ToWhom],BODY)
Mailstart.quit()