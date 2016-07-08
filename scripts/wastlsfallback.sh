#!/bin/bash
waspath=`grep "location id='IBM WebSphere Application Server" /var/ibm/InstallationManager/installed.xml | awk '{print $8}' | cut -d "'" -f2`
xmllist=`find $waspath/profiles -name security.xml`
propslist=`find $waspath/profiles -name ssl.client.props | grep 'properties'`
bakfile=`find $waspath/profiles -name security.xml.bak | wc -l`
oldfile=`find $waspath/profiles -name security.xml.old | wc -l`
if [ $bakfile -eq 0 ];then
echo 'TLS is not fixed,please run the script wastls.sh!'
exit
fi
if [ $oldfile -gt 0 ];then
echo 'TLS is already fixed!'
exit
fi
for xml in $xmllist;
do
xmlfilepath=`dirname $xml`
mv $xml $xmlfilepath/security\.xml\.old
cp $xmlfilepath/security\.xml\.bak $xmlfilepath/security\.xml
done
for props in $propslist;
do
propsfilepath=`dirname $props`
mv $props $propsfilepath/ssl\.client\.props\.old
cp $propsfilepath/ssl\.client\.props\.bak $propsfilepath/ssl\.client\.props
done
