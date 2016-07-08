#!/bin/bash
#WebSphere Application Server Administration
diskut=`df -h | grep -w / | awk '{print $4}' | cut -d "G" -f1`
function spacepre() {
if [ $diskut -lt 3 ];then
echo 'The disk space is less then 3G!' && exit 1
fi
}
function guiinstall() {
guipackage=`rpm -qa | grep $1`
if [ ! $guipackage ];then
yum -y install $1
fi
}
function menue() {
sleep 1
cat << eof
#################################################
#                                               #
#  WebSphere Application Server Administration  #
#                                               #
#################################################
#   Number & Administration function:           #
#   1.Download Package                          #
#   2.Install IBM Installation Manager          #
#   3.Install IBM WebSphere Application Server  #
#   4.Install IBM Http Server                   #
#   5.Install Plugin-in Server                  #
#   6.Upgrade To FP9                            #
#   7.Security Change                           #
#   8.Return To Menue                           #
#   9.Quit                                      #
#################################################
#  Contact:Gang GY Ye/China/IBM                 #
#          Neng NY Yi/China/IBM                 #
#################################################
eof
}

while :
menue
do
read -p 'Please select your administration function number: ' option
case $option in
1)
#diskut=`df -h | grep -w / | awk '{print $4}' | cut -d "G" -f1`
#if [ $diskut -gt 6 ];then
packageaddress=http://9.98.12.150/ftp/MIDDLEWARE/WAS/
IIMaddress=agent.installer.linux.gtk.x86_1.8.3000.20150606_0047.zip
waspackage1=wasnd8.5.5/WAS_ND_V8.5.5_1_OF_3.zip
waspackage2=wasnd8.5.5/WAS_ND_V8.5.5_2_OF_3.zip
waspackage3=wasnd8.5.5/WAS_ND_V8.5.5_3_OF_3.zip
wasfp9package1=8.5.5.9/8.5.5-WS-WAS-FP0000009-part1.zip
wasfp9package2=8.5.5.9/8.5.5-WS-WAS-FP0000009-part2.zip
wassupplp1=wasnd8.5.5/WAS_V8.5.5_SUPPL_1_OF_3.zip
wassupplp2=wasnd8.5.5/WAS_V8.5.5_SUPPL_2_OF_3.zip
wassupplp3=wasnd8.5.5/WAS_V8.5.5_SUPPL_3_OF_3.zip
wassupplp1fp9=8.5.5.9/8.5.5-WS-WASSupplements-FP0000009-part1.zip
wassupplp2fp9=8.5.5.9/8.5.5-WS-WASSupplements-FP0000009-part2.zip
wasp1=WAS_ND_V8.5.5_1_OF_3.zip
wasp2=WAS_ND_V8.5.5_2_OF_3.zip
wasp3=WAS_ND_V8.5.5_3_OF_3.zip
wasp1suppl=WAS_V8.5.5_SUPPL_1_OF_3.zip
wasp2suppl=WAS_V8.5.5_SUPPL_2_OF_3.zip
wasp3suppl=WAS_V8.5.5_SUPPL_3_OF_3.zip
wasfp9p1=8.5.5-WS-WAS-FP0000009-part1.zip
wasfp9p2=8.5.5-WS-WAS-FP0000009-part2.zip
wassupplfp9p1=8.5.5-WS-WASSupplements-FP0000009-part1.zip
wassupplfp9p2=8.5.5-WS-WASSupplements-FP0000009-part2.zip
echo 'Please select the package you want to download!'
select package in 'IM' 'WASND8.5.5' 'WASND8.5.5SUPPL' 'WASND8.5.5FP9' 'WASND8.5.5SUPPLFP9' 'Back'
do
case $package in 
IM)
spacepre
[ ! -e IMpackage ] && mkdir IMpackage
if [ ! -e IMpackage/$IIMaddress ];then
wget -P IMpackage $packageaddress$IIMaddress && echo IM package download sucessfully under `dirname $0`/IMpackage
else
echo The IM package is already download!
fi
break
;;
WASND8\.5\.5)
spacepre
[ ! -e WASpackage ] && mkdir WASpackage
if [ ! -e WASpackage/$wasp1 ];then
wget -P WASpackage $packageaddress$waspackage1 && echo WAS package 1 download sucessfully under `dirname $0`/WASpackage
else
echo The WAS package 1 is already download!
sleep 1
fi
if [ ! -e WASpackage/$wasp2 ];then
wget -P WASpackage $packageaddress$waspackage2 && echo WAS package 2 download sucessfully under `dirname $0`/WASpackage
else
echo The WAS package 2 is already download!
sleep 1
fi
if [ ! -e WASpackage/$wasp3 ];then
wget -P WASpackage $packageaddress$waspackage3 && echo WAS package 3 download sucessfully under `dirname $0`/WASpackage
else
echo The WAS package 3 is already download!
sleep 1
fi
break
;;
WASND8\.5\.5SUPPL)
spacepre
[ ! -d WASpackagesuppl ] && mkdir WASpackagesuppl
if [ ! -e WASpackagesuppl/$wasp1suppl ];then
wget -P WASpackagesuppl $packageaddress$wassupplp1 && echo WAS suppl package 1 download sucessfully under `dirname $0`/WASpackagesuppl
else
echo The WAS suppl package 1 is already download!
sleep 1
fi
if [ ! -e WASpackagesuppl/$wasp2suppl ];then
wget -P WASpackagesuppl $packageaddress$wassupplp2 && echo WAS suppl package 2 download sucessfully under `dirname $0`/WASpackagesuppl
else
echo The WAS package suppl 2 is already download!
sleep 1
fi
if [ ! -e WASpackagesuppl/$wasp3suppl ];then
wget -P WASpackagesuppl $packageaddress$wassupplp3 && echo WAS suppl package 3 download sucessfully under `dirname $0`/WASpackagesuppl
else
echo The WAS package suppl 3 is already download!
sleep 1
fi
break
;;
WASND8\.5\.5SUPPLFP9)
spacepre
[ ! -d WASpackagesupplFP9 ] && mkdir WASpackagesupplFP9
if [ ! -e WASpackagesupplFP9/$wassupplfp9p1 ];then
wget -P WASpackagesupplFP9 $packageaddress$wassupplp1fp9 && echo WAS suppl FP9 package 1 download sucessfully under `dirname $0`/WASpackagesupplFP9
else
echo The WAS package FP9suppl 1 is already download!
sleep 1
fi
if [ ! -e WASpackagesupplFP9/$wassupplfp9p2 ];then
wget -P WASpackagesupplFP9 $packageaddress$wassupplp2fp9 && echo WAS suppl FP9 package 2 download sucessfully under `dirname $0`/WASpackagesupplFP9
else
echo The WAS package FP9suppl 2 is already download!
sleep 1
fi
break
;;
WASND8\.5\.5FP9)
spacepre
[ ! -e WASFP9package ] && mkdir WASFP9package
if [ ! -e WASFP9package/$wasfp9p1 ];then
wget -P WASFP9package $packageaddress$wasfp9package1 && echo WAS FP9 package 1 download sucessfully under `dirname $0`/WASFP9package
else
echo The WAS FP9 package 1 is already download!
sleep 1
fi
if [ ! -e WASFP9package/$wasfp9p2 ];then
wget -P WASFP9package $packageaddress$wasfp9package2 && echo WAS FP9 package 2 download sucessfully under `dirname $0`/WASFP9package
else
echo The WAS FP9 package 2 is already download!
sleep 1
fi
break
;;
Back)
clear
break
;;
esac
done
#else
#echo Your root disk don't have enough space
#fi
;;
2)
read -p 'Are you sure you want to install IM?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
wget -qO- --no-check-certificate https://rhn.linux.ibm.com/pub/bootstrap/bootstrap.sh | /bin/bash
rhnreg_ks --force --username=dstlex@us.ibm.com --password=********
for package in 'gtk2-engines.*i686' 'gtk2-[0-9].*i686' 'libXtst.*i686' 'compat-libstdc++-33.
i686' 'compat-libstdc++-33.x86_64'
do
guiinstall $package
done
if [ -d /var/ibm/InstallationManager ];then
sleep 1
echo 'IBM InstallationManager is already existed ' && break
else
cd IMpackage
unzip $IIMaddress
echo 'The installation is starting and it will take a while...............'
./installc -log imlog -acceptLicense
break
fi
;;
3)
read -p 'Are you sure you want to install WAS?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
wasinstalled=`grep 'location id' /var/ibm/InstallationManager/installed.xml | grep 'IBM WebSphere Application Server V8.5' | wc -l`
if [ $wasinstalled -ge 1 ];then
sleep 1
echo 'WebSphere Application Server V8.5 is already existed' && break
else
cd WASpackage
wasdir=`pwd`
unzip WAS_ND_V8.5.5_1_OF_3.zip
unzip WAS_ND_V8.5.5_2_OF_3.zip
unzip WAS_ND_V8.5.5_3_OF_3.zip
wasreposity=$wasdir/repository.config
waspackageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $wasreposity`
echo 'The installation is starting and it will take a while...............'
/opt/IBM/InstallationManager/eclipse/tools/imcl install $waspackageid -repositories $wasreposity -installationDirectory /opt/IBM/WebSphere/AppServer -sharedResourcesDirectory /opt/IBM/IMShared -accessRights admin -preferences preference_key=value -properties property_key=value -acceptLicense
break
fi
;;
4)
read -p 'Are you sure you want to install IHS?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
ihsinstalled=`grep 'location id' /var/ibm/InstallationManager/installed.xml | grep 'IBM HTTP Server V8.5' | wc -l`
if [ $ihsinstalled -ge 1 ];then
sleep 1
echo 'IBM HTTP Server V8.5 is already existed' && break
else
cd WASpackagesuppl
ihsdir=`pwd`
unzip WAS_V8.5.5_SUPPL_1_OF_3.zip
unzip WAS_V8.5.5_SUPPL_2_OF_3.zip
unzip WAS_V8.5.5_SUPPL_3_OF_3.zip
ihsreposity=$ihsdir/repository.config
ihspackageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $ihsreposity | grep 'IHS'`
echo 'The installation is starting and it will take a while...............'
/opt/IBM/InstallationManager/eclipse/tools/imcl install $ihspackageid -repositories $ihsreposity -installationDirectory /opt/IBM/HttpServer -sharedResourcesDirectory /opt/IBM/IMShared -acceptLicense -properties "user.ihs.httpPort=80,user.ihs.allowNonRootSilentInstall=true" -log /tmp/installihs_log.xml
break
fi
;;
5)
read -p 'Are you sure you want to install Plug-in?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
pluginstalled=`grep 'location id' /var/ibm/InstallationManager/installed.xml | grep 'Web Server Plug-ins' | wc -l`
if [ $pluginstalled -ge 1 ];then
sleep 1
echo 'Web Server Plug-ins is already existed' && break
else
cd WASpackagesuppl
plugindir=`pwd`
pluginreposity=$plugindir/repository.config
pluginpackageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $pluginreposity | grep 'PLG'`
wctpackageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $pluginreposity | grep 'WCT'`
echo 'The installation is starting and it will take a while...............'
/opt/IBM/InstallationManager/eclipse/tools/imcl install $pluginpackageid -repositories $pluginreposity -installationDirectory /opt/IBM/Plug-in -sharedResourcesDirectory /opt/IBM/IMShared -acceptLicense -log /tmp/installplug_log.xml
/opt/IBM/InstallationManager/eclipse/tools/imcl install $wctpackageid -repositories $pluginreposity -installationDirectory /opt/IBM/WCT -sharedResourcesDirectory /opt/IBM/IMShared -acceptLicense -log /tmp/installwct_log.xml
break
fi
;;
6)
echo 'Please select product you want to upgrade!'
select fp9option in 'WASFP9' 'WASSUPPlFP9' 'Back'
do
case $fp9option in
WASFP9)
read -p 'Are you sure you want to install WAS FP9?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
installedwaspath=`grep "location id='IBM WebSphere Application Server V8.5'" /var/ibm/InstallationManager/installed.xml | awk '{print $8}' | cut -d "'" -f2`
cd WASFP9package
wasfp9dir=`pwd`
unzip 8.5.5-WS-WAS-FP0000009-part1.zip
unzip 8.5.5-WS-WAS-FP0000009-part2.zip
wasfp9reposity=$wasfp9dir/repository.config
wasfp9packageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $wasfp9reposity | grep 'com.ibm.websphere.ND.v85'`
echo 'The installation is starting and it will take a while...............'
/opt/IBM/InstallationManager/eclipse/tools/imcl install $wasfp9packageid -repositories $wasfp9reposity -installationDirectory $installedwaspath -acceptLicense
break
;;
WASSUPPlFP9)
read -p 'Are you sure you want to install WASSUPPL FP9?[yes or no]:' imoption
if [[ $imoption = [Nn][Oo] ]];then
break
fi
installedihspath=`grep "location id='IBM HTTP Server V8.5'" /var/ibm/InstallationManager/installed.xml | awk '{print $7}' | cut -d "'" -f2`
installedpluginpath=`grep "location id='Web Server Plug-ins for IBM WebSphere Application Server V8.5'" /var/ibm/InstallationManager/installed.xml | awk '{print $12}' | cut -d "'" -f2`
cd WASpackagesupplFP9
wassupplfp9dir=`pwd`
unzip 8.5.5-WS-WASSupplements-FP0000009-part1.zip
unzip 8.5.5-WS-WASSupplements-FP0000009-part2.zip
wassupplfp9reposity=$wassupplfp9dir/repository.config
ihsfp9packageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $wassupplfp9reposity | grep 'com.ibm.websphere.IHS.v85'`
pluginfp9packageid=`/opt/IBM/InstallationManager/eclipse/tools/imcl listAvailablePackages -repositories $wassupplfp9reposity | grep 'com.ibm.websphere.PLG.v85'`
echo 'The installation is starting and it will take a while...............'
/opt/IBM/InstallationManager/eclipse/tools/imcl install $ihsfp9packageid -repositories $wassupplfp9reposity -installationDirectory $installedihspath -acceptLicense
/opt/IBM/InstallationManager/eclipse/tools/imcl install $pluginfp9packageid -repositories $wassupplfp9reposity -installationDirectory $installedpluginpath -acceptLicense
break
;;
Back)
clear
break
;;
esac
done
;;
7)
echo 'Please select which vulnerability you want to fix!'
select vultobefix in 'TLSv1.2' 'TLSv1.2roll-backup' 'Back'
do
case $vultobefix in
TLSv1\.2)
waspath=`grep "location id='IBM WebSphere Application Server" /var/ibm/InstallationManager/installed.xml | awk '{print $8}' | cut -d "'" -f2`
xmllist=`find $waspath/profiles -name security.xml`
propslist=`find $waspath/profiles -name ssl.client.props | grep 'properties'`
for xml in $xmllist;
do
xmlfilepath=`dirname $xml`
cp $xml $xmlfilepath/security\.xml\.bak
sed -i 's/sslProtocol="[^"]*"/sslProtocol="TLSv1.2"/' $xml && echo "$xml has been changed to enable TLSv1.2"
sleep 1
done
for props in $propslist;
do
propsfilepath=`dirname $props`
cp $props $propsfilepath/ssl\.client\.props\.bak
sed -i 's/ssl.protocol=.*/ssl.protocol=TLSv1.2/' $props && echo "$props has been changed to enable TLSv1.2"
sleep 1
done
break
;;
TLSv1.2roll-backup)
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
break
;;
Back)
clear
break
;;
esac	
done	
;;
8)
clear
;;
9)
exit 0
;;
esac
done


