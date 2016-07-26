#!/usr/bin/env python
 
       import xlwt
       import   MySQLdb
       wbk=xlwt.Workbook()
       sheet=wbk.add_sheet('sheet 1')
       sheet.write(0,0,'company')
       sheet.write(0,1,'city')
       row=1
       conn=MySQLdb.connect(host='XXX',user='XXX',passwd='XXX',db='gh')
       cursor=conn.cursor()
       cursor.execute('select * from customers')
       for com,city in cursor.fetchall():
               sheet.write(row,0,com)
               sheet.write(row,1,city)
                row+=1
        wbk.save(city.xls)
        cursor.close()
        conn.commit()
        conn.close()