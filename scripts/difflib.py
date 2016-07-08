import sys
import difflib
file1=sys.argv[1]
file2=sys.argv[2]
def gettext(filename):
    filehandle=open(filename,'rb')
    text=filehandle.read().splitlines()
    filehandle.close
    return text
c_file1=gettext(file1)
c_file2=gettext(file2)
d=difflib.HtmlDiff()
print(d.make_file(c_file1,c_file2))