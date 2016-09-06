
import socket,time
HOST='9.98.13.40'
PORT=50008
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((HOST,PORT))
while 1:
    s.send('Hello World')
    data=s.recv(1024)
    time.sleep(2)
    print 'Received',repr(data)
s.close()


