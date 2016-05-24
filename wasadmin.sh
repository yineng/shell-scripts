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
#  Administration function:                     #
#   1.Download Package                          #
#   2.Install IBM Installation Manager          #
#   3.Install IBM WebSphere Application Server  #
#   4.Install IBM Http Server                   #
#   5.Install Plugin-in Server                  #
#   6.Return To Menue                           #
#   7.Quit                                      #
#################################################
#  Contact:Gang GY Ye/China/IBM                 #
#          Neng NY Yi/China/IBM                 #
#################################################
eof
}

while :
menue
do
read -p 'Please select your administration function: ' option
case $option in
1)
#diskut=`df -h | grep -w / | awk '{print $4}' | cut -d "G" -f1`
#if [ $diskut -gt 6 ];then
packageaddress=http://9.98.12.150/ftp/MIDDLEWARE/WAS/
IIMaddress=agent.installer.linux.gtk.x86_1.8.3000.20150606_0047.zip
waspackage1=wasnd8.5.5/WAS_ND_V8.5.5_1_OF_3.zip
waspackage2=wasnd8.5.5/WAS_ND_V8.5.5_2_OF_3.zip
waspackage3=wasnd8.5.5/WAS_ND_V8.5.5_3_OF_3.zip
wassupplp1=wasnd8.5.5/WAS_V8.5.5_SUPPL_1_OF_3.zip
wassupplp2=wasnd8.5.5/WAS_V8.5.5_SUPPL_2_OF_3.zip
wassupplp3=wasnd8.5.5/WAS_V8.5.5_SUPPL_3_OF_3.zip
wasp1=WAS_ND_V8.5.5_1_OF_3.zip
wasp2=WAS_ND_V8.5.5_2_OF_3.zip
wasp3=WAS_ND_V8.5.5_3_OF_3.zip
wasp1suppl=WAS_V8.5.5_SUPPL_1_OF_3.zip
wasp2suppl=WAS_V8.5.5_SUPPL_2_OF_3.zip
wasp3suppl=WAS_V8.5.5_SUPPL_3_OF_3.zip
echo 'Please select the package you want to download!'
select package in 'IM' 'WASND8.5.5' 'WASND8.5.5SUPPL' 'Back'
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
rhnreg_ks --force --username=dstlex@us.ibm.com --password=wryi83ljgd
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
read -p 'Are you sure you want to install IHS?[yes or no]:' imoption
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
clear
;;
7)
exit 0
;;
esac
done
