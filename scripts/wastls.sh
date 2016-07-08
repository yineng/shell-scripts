#!/bin/bash
waspath=`grep "location id='IBM WebSphere Application Server" /var/ibm/InstallationManager/installed.xml | awk '{print $8}' | cut -d "'" -f2`
xmllist=`find $waspath/profiles -name security.xml`
propslist=`find $waspath/profiles -name ssl.client.props | grep 'properties'`
for xml in $xmllist;
do
xmlfilepath=`dirname $xml`
cp $xml $xmlfilepath/security\.xml\.bak
sed -i 's/sslProtocol="[^"]*"/sslProtocol="TLSv1.2"/' $xml
done
for props in $propslist;
do
propsfilepath=`dirname $props`
cp $props $propsfilepath/ssl\.client\.props\.bak
sed -i 's/ssl.protocol=.*/ssl.protocol=TLSv1.2/' $props
done

