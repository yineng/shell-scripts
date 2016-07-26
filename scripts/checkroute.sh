routecheck1=`/sbin/route -n | grep '10.0.0.0        10.111.103.66' | wc -l`
routecheck9=`/sbin/route -n | grep '9.0.0.0         10.111.103.66' | wc -l`
routecheckdefault=`/sbin/route -n | grep '0.0.0.0         10.111.103.66' | wc -l`
[ `echo $routecheck1 | awk -v bi=1 '{print($1==bi)?"1":"0"}'` -eq "1" ] && /sbin/route del -net 10.0.0.0/8 gw 10.111.103.66 dev eth0
[ `echo $routecheck9 | awk -v bi=1 '{print($1==bi)?"1":"0"}'` -eq "1" ] && /sbin/route del -net 9.0.0.0/8 gw 10.111.103.66 dev eth0
[ `echo $routecheckdefault | awk -v bi=1 '{print($1==bi)?"1":"0"}'` -eq "1" ] && /sbin/route del default gw 10.111.103.66 dev eth0