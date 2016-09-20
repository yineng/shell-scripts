from threading import Thread
import time
from threading import Lock
from threading import BoundedSemaphore
num=0
def test(n):
    time.sleep(1)
    global num
    sema_temp.acquire()
    num+=1
    sema_temp.release()
    print '\n%s' % num
sema_temp=BoundedSemaphore(4)
for i in range(500):
    temp=Thread(target=test,args=(i,))
    temp.start()
