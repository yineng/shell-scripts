from threading import Thread
import time
from threading import Lock
num=0
temp_lock=Lock()
def test(n):
    time.sleep(1)
    global num
    temp_lock.acquire()
    num+=1
    temp_lock.release()
    time.sleep(0.01)
    print '\n%s' % num

for i in range(500):
    temp=Thread(target=test,args=(i,))
    temp.start()
