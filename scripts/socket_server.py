import socket,os
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
        conn.sendall(data.upper())
conn.close()