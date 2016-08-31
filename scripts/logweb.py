from flask import Flask,request,render_template
import MySQLdb
app=Flask(__name__)
dbcon=MySQLdb.connect(user='root',passwd='Zaq!2wsx',db='serverlogDB',host='127.0.0.1')
cur=dbcon.cursor()
@app.route('/')
def index():
    cur.execute('select * from log order by accesstimes desc')
    res='''
    <table border="2">
    <tr><td>User</td><td>IP</td><td>Access times</td></tr>
    '''
    for eachentry in cur.fetchall():
    	res+='<tr><td>%s</td><td>%s</td><td>%s</td></tr>' % eachentry
    res+='</table>'
    return res
if __name__=='__main__':
    app.run(host='0.0.0.0',port=8011)