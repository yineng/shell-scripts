from flask import Flask,request,render_template
import MySQLdb
app=Flask(__name__)
dbcon=MySQLdb.connect(user='root',passwd='Zaq!2wsx',db='serverlogDB',host='127.0.0.1')
cur=dbcon.cursor()
@app.route('/')
def index():
    cur.execute('select * from log order by accesstimes desc')
    res='''
    <link href="bootstrap.min.css" rel="stylesheet">
    <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
    <div class="navbar-header">
    <!-- The mobile navbar-toggle button can be safely removed since you do not need it in a non-responsive implementation -->
    <a class="navbar-brand" href="#">AICS Operation China</a>
    </div>
    </nav>
    <div class="container" style="margin-top:30px">
    <div class="page-header">
    <h1>Server Log Analysis</h1>
    <p class="lead">This is web system for access log analysis.The access user and access ip can be detected and ordered by access times <a href="https://dst.ibm.com/">Read the documentation</a> for more information.</p>
    </div>
    <div class="row">
        <div class="col-md-6">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>User</th>
                <th>Access IP</th>
                <th>Access times</th>
              </tr>
            </thead>
            <tbody>
    '''
    for eachentry in cur.fetchall():
        res+='<tr><td>%s</td><td>%s</td><td>%s</td></tr>' % eachentry
    res+='''
    </tbody>
    </table>
    </div>
    </div>
    '''
    return res
if __name__=='__main__':
    app.run(host='0.0.0.0',port=8011)