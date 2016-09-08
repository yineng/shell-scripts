import socket,time
HOST='9.98.13.40'
PORT=50008
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((HOST,PORT))
while 1:
    cmd=raw_input("Your command:").strip()
    if len(cmd)==0:
        continue
    s.sendall(cmd)
    data=s.recv(8096)
    print data
s.close()