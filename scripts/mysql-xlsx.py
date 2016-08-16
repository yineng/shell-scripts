import MySQLdb
import xlwt
conn=MySQLdb.connect(host='9.9.153.77',port=3306,user='dstticket',passwd='two2tango',db='dstticket')
cur=conn.cursor()
count=cur.execute("SELECT c.serverName      AS `HostName`,a.shortDesc       AS `Subject`,a.Ticket_ID       AS `TicketNum`,e.name            AS `TicketStatus`,d.closedTimeStamp AS `ClosedData`,f.fullName        AS `Submitter` FROM Problem a,ServerTransaction b,Server c,Ticket d,TicketStatus e,`User` f WHERE a.Ticket_ID = b.Ticket_ID AND b.Server_ID = c.Server_ID AND a.Ticket_ID = d.Ticket_ID AND d.TicketStatus_ID = e.TicketStatus_ID AND d.TicketSubmitter_ID = f.User_ID AND a.shortDesc LIKE '%Monitoring%' AND f.emailAddress IN ('dlrenzg@cn.ibm.com','caixrui@cn.ibm.com','wangheqi@cn.ibm.com','mnzhang@cn.ibm.com') AND d.createTimeStamp > '2016-07-25' AND d.createTimeStamp < '2016-07-31'")
cur.scroll(0,mode='absolute')
results=cur.fetchall()
fields=cur.description
wbk=xlwt.Workbook()
sheet=wbk.add_sheet('test',cell_overwrite_ok=True)
for ifs in range(0,len(fields)):
    sheet.write(0,ifs,fields[ifs][0])
ics=1
jcs=0
for ics in range(1,len(results)+1):
    for jcs in range(0,len(fields)):
        sheet.write(ics,jcs,results[ics-1][jcs])
wbk.save('test.xlsx')
cur.close()
conn.close()