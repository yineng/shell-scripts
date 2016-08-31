import re
import MySQLdb
con=MySQLdb.connect(user='root',passwd='Zaq!2wsx',db='serverlogDB',host='127.0.0.1')
con.autocommit(True)
cur=con.cursor()
res={}
logfile=open('secure.log').read()
accesspattern='.*Accepted publickey.*'
logresult=re.findall(accesspattern,logfile)
for eachlog in logresult:
    arr=eachlog.split(' ')
    user=arr[8]
    access_address=arr[10]
    res[(user,access_address)]=res.get((user,access_address),0)+1
res_list=[(k[0],k[1],v) for k,v in res.items()]
# for eachresult in sorted(res_list,key=lambda x:x[1],reverse=True)[:10]
    # print eachresult
for eachrecord in res_list:
	sql='insert log values("%s","%s",%s)' % eachrecord
	cur.execute(sql)