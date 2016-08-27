from flask import Flask,request,render_template
import nmap
app=Flask(__name__)
ip_list=[]
port_list=[]
service_list=[]
@app.route('/')
def index():
    return get_all_html()
@app.route('/add')
def add():
    global total_data
    ip_address=request.args.get('ip_address')
    if not ip_address:
        res='<p>need IP address!!!</p>'+get_all_html()
    else:
        nm=nmap.PortScanner()
        nm.scan(hosts=ip_address,arguments=' -v -sS -p '+'1-65535')
        global each_host
        for each_host in nm.all_hosts():
            ports_results=nm[each_host]['tcp'].keys()
            for server_port in ports_results:
                server_service=nm[each_host]['tcp'][server_port]['name']
                ip_list.append(each_host)
                port_list.append(server_port)
                service_list.append(server_service)
                get_table_html()
        res=get_all_html()
        del ip_list[:]
        del port_list[:]
        del service_list[:]
    return res
def get_head_html():
    return '''
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>service port scanning</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    </head>
    <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">AICS Opeartion CHINA</a>
        </div>
      </div>
    </nav>
    <div class="jumbotron">
      <div class="container">
        <h3>Hello, everybody!</h3>
        <p>This is a web system for detecting running service on AICS servers. Enter ipaddress into input box and click scan button,scan finding will show in web form below.Please note this system 
is for AICS internal use!</p>
        <p><a class="btn btn-primary btn-lg" href="https://dst.ibm.com/" role="button">Learn more &raquo;</a></p>
      </div>
    </div>
    '''
def get_table_html():
    temp_str='''
    <div class="container">
    <div class="row">
    <div class="col-md-6">
    <table class="table table-striped">
    <thead>
    '''
    temp_str+='''
    <tr>
    <th>Port</th>
    <th>Service</th>
    <th>IP</th>
    </tr>
    </thead>
    <tbody>
    '''
    for each_port,each_service,each_ip in zip(port_list,service_list,ip_list):
        temp_str+='<tr><td>%s</td><td>%s</td><td>%s</td></tr>' % (each_port,each_service,each_ip)
    temp_str+='''
    </tbody>
          </table>
        </div>
      </div>
    '''
    return temp_str
def get_form_html():
    return '''
    <form action="/add">
    <div class="col-xs-4" style="width:30%;align:center;margin-left:210px">
    <input type="text" name='ip_address' class="form-control" placeholder="IP address" >
    </div>
    <input type="submit" class="btn btn-default" value='Scan'>
    </form>
     '''
def get_bottom_html():
    return '''
    <hr size="10">
    <footer>
    <p>&copy; AICS Operation CHINA</p>
    </footer>
    </div> <!-- /container -->
    </body>
    </html>
    '''
def get_all_html():
    return get_head_html()+get_form_html()+get_table_html()+get_bottom_html()
if __name__=='__main__':
    app.run(host='0.0.0.0',port=9097)
