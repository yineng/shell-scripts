#coding:utf8
from threading import Thread
import time
from Queue import Queue
class producers(Thread):
    def __init__(self,producer_name,que_name):
        self.__name=producer_name
        self.__que=que_name
        super(producers,self).__init__()
    def run(self):
        while True:
            if self.__que.full():
                time.sleep(1)
            else:
                self.__que.put("包子")
                time.sleep(1)
                print "%s生产了一个包子" % self.__name
class consumers(Thread):
    def __init__(self,consumer_name,que_name):
        self.__name=consumer_name
        self.__que=que_name
        super(consumers,self).__init__()
    def run(self):
        while True:
            if self.__que.empty():
                time.sleep(1)
            else:
                self.__que.get()
                time.sleep(1)
                print "%s消费了一个包子" % self.__name
que=Queue(100)
basheng=producers('basheng',que)
basheng.start()
dazhu=producers('dazhu',que)
dazhu.start()
shengle=producers('shengle',que)
shengle.start()
for item in range(20):
    name="damen%d" % item
    temp=consumers(name,que)
    temp.start()
