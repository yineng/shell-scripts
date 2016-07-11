import sys
import nmap
scan_row=[]
input_date=input('请输入地址和端口：')
scan_row=input_date.split(" ")
if len(scan_row)!=2:
    print("输入错误，请按照例子输入;\"192.168.0.1/24 80,443,22\"")
    sys.exit(0)
hosts=scan_row[0]
port=scan_row[1]
try:
    nm=nmap.PortScanner()
except nmap.PortScannerError:
    print("namp no found",sys.exc_info()[0])
except:
    print("Unexpected error:",sys.exc_info()[0])
    sys.exit(0)
try:
    nm.scan(hosts=hosts,arguments=' -v -sS -p '+port)
except Exception as e:
    print("Scan error:"+str(e))
for host in nm.all_hosts():
    print('-'*35)
    print('Host: %s (%s)' % (host,nm[host].hostname()))
    print('state: %s' % nm[host].state())
    for proto in nm[host].all_protocols():
        print('-'*25)
        print('Protocol : %s' % proto)
        lport=nm[host][proto].keys()
#        lport.sort()
        for port in lport:
            print('port: %s\tstate: %s' % (port,nm[host][proto][port]['state']))
