#!/bin/bash

# Updated for $.broswer-msie error; will populate tracker list properly ; create check/start scripts; 
# create crontab entries. Rest is all perfect from Notos. Thanks.
#
# The Seedbox From Scratch Script
#   By Notos ---> https://github.com/Notos/
#     Modified by dannyti ---> https://github.com/dannyti/
#
######################################################################
#
#  Copyright (c) 2013 Notos (https://github.com/Notos/) & dannyti (https://github.com/dannyti/)
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: 
#
#  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#  --> Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
#
######################################################################
#
#  git clone -b master https://github.com/Notos/seedbox-from-scratch.git /etc/seedbox-from-scratch
#  sudo git stash; sudo git pull
#
apt-get --yes install lsb-release
  SBFSCURRENTVERSION1=14.06
  OS1=$(lsb_release -si)
  OSV1=$(lsb_release -rs)
  OSV11=$(sed 's/\..*//' /etc/debian_version)
  logfile="/dev/null"
#
# Changelog
#   Version 14.06 (By dannyti)
#   Jan 16 2015
#      - RTorrent 0.9.4 supported
#      - Openvpn Fixed and Working 
#      - Autodl tracker list correctly populated
#      - Diskspace fixed for multiuser environment
#      - Added http Data Download directory for users ; Can be accessed at http://Server-IP/private/Downloads ; Only http://
#      - Sitewide https only 
#      - User Login info can be accessed individually at http://Server-IP/private/SBinfo.txt 
#      - Mediainfo fixed ; installtion from source
#      - Jquery Error corrected 
#      - Crontab entries made for checking rtorrrent is running and starting it if not running
#      - Plowshare Fixed
#      - Deprecated seedboxInfo.php 
#
#  Version 2.1.9 (not stable yet)
#   Dec 26 2012 17:37 GMT-3
#     - RTorrent 0.9.3 support (optionally installed)
#     - New installRTorrent script: move to RTorrent 0.9.3 or back to 0.9.2 at any time
#     - Deluge v1.3.6 multi-user installation script (it will install the last stable version): installDeluge
#     - Optionally install Deluge when you first install your seedbox-from-scratch box
#
#  Version 2.1.8 (stable)
#     - Bug fix release
#
#  Version 2.1.4 (stable)
#   Dec 11 2012 2:34 GMT-3
#     - Debian 6 (Squeeze) Compatibile
#     - Check if user root is running the script
#     - vsftpd - FTP access with SSL (AUTH SSL - Explicit)
#     - vsftpd downgraded on Ubuntu to 2.3.2 (oneiric)
#     - iptables tweaked to make OpenVPN work as it should both on Ubuntu and Debian
#     - SABnzbd is now being installed from sources and works better
#     - New script: changeUserPassword <username> <password> <realm> --- example:  changeUserPassword notos 133t rutorrent
#     - restartSeedbox now kill processes even if there are users attached on screens
#     - Installs rar, unrar and zip separately from main installations to prevent script from breaking on bad sources from non-OVH providers
#
#  Version 2.1.2 (stable)
#   Nov 16 2012 20:48 GMT-3
#     - new upgradeSeedbox script (to download git files for a new version, it will not really upgrade it, at least for now :)
#     - ruTorrent fileshare Plugin (http://forums.rutorrent.org/index.php?topic=705.0)
#     - rapidleech (http://www.rapidleech.com/ - http://www.rapidleech.com/index.php?showtopic=2226|Go ** tutorial: http://www.seedm8.com/members/knowledgebase/24/Installing-Rapidleech-on-your-Seedbox.html
#
#  Version 2.1.1 (stable)
#   Nov 12 2012 20:15
#     - OpenVPN was not working as expected (fixed)
#     - OpenVPN port now is configurable (at main install) and you can change it anytime before reinstalling: /etc/seedbox-from-scratch/openvpn.info
#
#  Version 2.1.0 (not stable yet)
#   Nov 11 2012 20:15
#     - sabnzbd: http://wiki.sabnzbd.org/install-ubuntu-repo
#     - restartSeedbox script for each user
#     - User info files in /etc/seedbox-from-scratch/users
#     - Info about all users in https://hostname.tld/seedboxInfo.php
#     - Password protected webserver Document Root (/var/www/)
#
#  Version 2.0.0 (stable)
#   Oct 31 2012 23:59
#     - chroot jail for users, using JailKit (http://olivier.sessink.nl/jailkit/)
#     - Fail2ban for ssh and apache - it bans IPs that show the malicious signs -- too many password failures, seeking for exploits, etc.
#     - OpenVPN (after install you can download your key from http://<IP address or host name of your box>/rutorrent/vpn.zip)
#     - createSeedboxUser script now asks if you want your user jailed, to have SSH access and if it should be added to sudoers
#     - Optionally install packages JailKit, Webmin, Fail2ban and OpenVPN
#     - Choose between RTorrent 0.8.9 and 0.9.2 (and their respective libtorrent libraries)
#     - Upgrade and downgrade RTorrent at any time
#     - Full automated install, now you just have to download script and run it in your box:
#        > wget -N https://raw.github.com/Notos/seedbox-from-scratch/v2.x.x/seedbox-from-scratch.sh
#        > time bash ~/seedbox-from-scratch.sh
#     - Due to a recent outage of Webmin site and SourceForge's svn repositories, some packages are now in git and will not be downloaded from those sites
#     - Updated list of trackers in Autodl-irssi
#     - vsftpd FTP Server (working in chroot jail)
#     - New ruTorrent default theme: Oblivion
#
#  Version 1.30
#   Oct 23 2012 04:54:29
#     - Scripts now accept a full install without having to create variables and do anything else
#
#  Version 1.20
#   Oct 19 2012 03:24 (by Notos)
#    - Install OpenVPN - (BETA) Still not in the script, just an outside script
#      Tested client: http://openvpn.net/index.php?option=com_content&id=357
#
#  Version 1.11
#   Oct 18 2012 05:13 (by Notos)
#    - Added scripts to downgrade and upgrade RTorrent
#
#    - Added all supported plowshare sites into fileupload plugin: 115, 1fichier, 2shared, 4shared, bayfiles, bitshare, config, cramit, data_hu, dataport_cz,
#      depositfiles, divshare, dl_free_fr, euroshare_eu, extabit, filebox, filemates, filepost, freakshare, go4up, hotfile, mediafire, megashares, mirrorcreator, multiupload, netload_in,
#      oron, putlocker, rapidgator, rapidshare, ryushare, sendspace, shareonline_biz, turbobit, uploaded_net, uploadhero, uploading, uptobox, zalaa, zippyshare
#
#  Version 1.10
#   06/10/2012 14:18 (by Notos)
#    - Added Fileupload plugin
#
#    - Added all supported plowshare sites into fileupload plugin: 115, 1fichier, 2shared, 4shared, bayfiles, bitshare, config, cramit, data_hu, dataport_cz,
#      depositfiles, divshare, dl_free_fr, euroshare_eu, extabit, filebox, filemates, filepost, freakshare, go4up, hotfile, mediafire, megashares, mirrorcreator, multiupload, netload_in,
#      oron, putlocker, rapidgator, rapidshare, ryushare, sendspace, shareonline_biz, turbobit, uploaded_net, uploadhero, uploading, uptobox, zalaa, zippyshare
#
#  Version 1.00
#   30/09/2012 14:18 (by Notos)
#    - Changing some file names and depoying version 1.00
#
#  Version 0.99b
#   27/09/2012 19:39 (by Notos)
#    - Quota for users
#    - Download dir inside user home
#
#  Version 0.99a
#   27/09/2012 19:39 (by Notos)
#    - Quota for users
#    - Download dir inside user home
#
#  Version 0.92a
#   28/08/2012 19:39 (by Notos)
#    - Also working on Debian now
#
#  Version 0.91a
#   24/08/2012 19:39 (by Notos)
#    - First multi-user version sent to public
#
#  Version 0.90a
#   22/08/2012 19:39 (by Notos)
#    - Working version for OVH Kimsufi 2G Server - Ubuntu Based
#
#  Version 0.89a
#   17/08/2012 19:39 (by Notos)
#
function getString
{
  local ISPASSWORD=$1
  local LABEL=$2
  local RETURN=$3
  local DEFAULT=$4
  local NEWVAR1=a
  local NEWVAR2=b
  local YESYES=YESyes
  local NONO=NOno
  local YESNO=$YESYES$NONO

  while [ ! $NEWVAR1 = $NEWVAR2 ] || [ -z "$NEWVAR1" ];
  do
    clear
    echo "#"
    echo "#"
    echo "# The Seedbox From Scratch Script"
    echo "#   By Notos ---> https://github.com/Notos/"
    echo "#   Modified by dannyti ---> https://github.com/dannyti/"
    echo "#"
    echo "#"
    echo

    if [ "$ISPASSWORD" == "YES" ]; then
      read -s -p "$DEFAULT" -p "$LABEL" NEWVAR1
    else
      read -e -i "$DEFAULT" -p "$LABEL" NEWVAR1
    fi
    if [ -z "$NEWVAR1" ]; then
      NEWVAR1=a
      continue
    fi

    if [ ! -z "$DEFAULT" ]; then
      if grep -q "$DEFAULT" <<< "$YESNO"; then
        if grep -q "$NEWVAR1" <<< "$YESNO"; then
          if grep -q "$NEWVAR1" <<< "$YESYES"; then
            NEWVAR1=YES
          else
            NEWVAR1=NO
          fi
        else
          NEWVAR1=a
        fi
      fi
    fi

    if [ "$NEWVAR1" == "$DEFAULT" ]; then
      NEWVAR2=$NEWVAR1
    else
      if [ "$ISPASSWORD" == "YES" ]; then
        echo
        read -s -p "Retype: " NEWVAR2
      else
        read -p "Retype: " NEWVAR2
      fi
      if [ -z "$NEWVAR2" ]; then
        NEWVAR2=b
        continue
      fi
    fi


    if [ ! -z "$DEFAULT" ]; then
      if grep -q "$DEFAULT" <<< "$YESNO"; then
        if grep -q "$NEWVAR2" <<< "$YESNO"; then
          if grep -q "$NEWVAR2" <<< "$YESYES"; then
            NEWVAR2=YES
          else
            NEWVAR2=NO
          fi
        else
          NEWVAR2=a
        fi
      fi
    fi
    echo "---> $NEWVAR2"

  done
  eval $RETURN=\$NEWVAR1
}
# 0.

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

clear

# 1.

#localhost is ok this rtorrent/rutorrent installation
IPADDRESS1=`ifconfig | sed -n 's/.*inet addr:\([0-9.]\+\)\s.*/\1/p' | grep -v 127 | head -n 1`
CHROOTJAIL1=NO

#those passwords will be changed in the next steps
PASSWORD1=a
PASSWORD2=b

getString NO  "You need to create an user for your seedbox: " NEWUSER1
getString YES "Password for user $NEWUSER1: " PASSWORD1
getString NO  "IP address of your box: " IPADDRESS1 $IPADDRESS1
getString NO  "SSH port: " NEWSSHPORT1 21976
getString NO  "vsftp port (usually 21): " NEWFTPPORT1 21201
getString NO  "OpenVPN port: " OPENVPNPORT1 31195
#getString NO  "Do you want to have some of your users in a chroot jail? " CHROOTJAIL1 YES
getString NO  "Install Webmin? " INSTALLWEBMIN1 YES
getString NO  "Install Fail2ban? " INSTALLFAIL2BAN1 YES
getString NO  "Install OpenVPN? " INSTALLOPENVPN1 NO
getString NO  "Install SABnzbd? " INSTALLSABNZBD1 NO
getString NO  "Install Rapidleech? " INSTALLRAPIDLEECH1 NO
getString NO  "Install Deluge? " INSTALLDELUGE1 NO
getString NO  "Wich RTorrent version would you like to install, '0.9.3' or '0.9.4' or '0.9.6'? " RTORRENT1 0.9.6

if [ "$RTORRENT1" != "0.9.3" ] && [ "$RTORRENT1" != "0.9.6" ] && [ "$RTORRENT1" != "0.9.4" ]; then
  echo "$RTORRENT1 typed is not 0.9.6 or 0.9.4 or 0.9.3!"
  exit 1
fi

if [ "$OSV1" = "14.04" ]; then
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 >> $logfile 2>&1
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 >> $logfile 2>&1
fi
echo -e "\033[0;32;148m........\033[39m"
echo -e "\033[0;32;148m.............\033[39m"
echo -e "\033[0;32;148mWork in progress.........\033[39m"
echo -e "\033[0;32;148mPlease Standby................\033[39m"
apt-get --yes update >> $logfile 2>&1
apt-get --yes install whois sudo makepasswd nano >> $logfile 2>&1
apt-get --yes install git >> $logfile 2>&1

rm -f -r /etc/seedbox-from-scratch
git clone -b v$SBFSCURRENTVERSION1 https://github.com/dannyti/seedbox-from-scratch.git /etc/seedbox-from-scratch >> $logfile 2>&1
mkdir -p cd /etc/seedbox-from-scratch/source
mkdir -p cd /etc/seedbox-from-scratch/users

if [ ! -f /etc/seedbox-from-scratch/seedbox-from-scratch.sh ]; then
  clear
  echo Looks like something is wrong, this script was not able to download its whole git repository.
  set -e
  exit 1
fi

# 3.1

#show all commands
#set -x verbose
echo -e "\033[0;32;148mI am installing random stuff, Do you like coffee ?\033[39m"

# 4.
perl -pi -e "s/Port 22/Port $NEWSSHPORT1/g" /etc/ssh/sshd_config
perl -pi -e "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
perl -pi -e "s/#Protocol 2/Protocol 2/g" /etc/ssh/sshd_config
perl -pi -e "s/X11Forwarding yes/X11Forwarding no/g" /etc/ssh/sshd_config

groupadd sshdusers
groupadd sftponly

mkdir -p /usr/share/terminfo/l/
cp /lib/terminfo/l/linux /usr/share/terminfo/l/
#echo '/usr/lib/openssh/sftp-server' >> /etc/shells
if [ "$OS1" = "Ubuntu" ]; then
  echo "" | tee -a /etc/ssh/sshd_config > /dev/null
  echo "UseDNS no" | tee -a /etc/ssh/sshd_config > /dev/null
  echo "AllowGroups sshdusers root" >> /etc/ssh/sshd_config
  echo "Match Group sftponly" >> /etc/ssh/sshd_config
  echo "ChrootDirectory %h" >> /etc/ssh/sshd_config
  echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config
  echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
fi

service ssh reload

# 6.
#remove cdrom from apt so it doesn't stop asking for it
perl -pi -e "s/deb cdrom/#deb cdrom/g" /etc/apt/sources.list
perl -pi.orig -e 's/^(deb .* universe)$/$1 multiverse/' /etc/apt/sources.list
#add non-free sources to Debian Squeeze# those two spaces below are on purpose
perl -pi -e "s/squeeze main/squeeze  main contrib non-free/g" /etc/apt/sources.list
perl -pi -e "s/squeeze-updates main/squeeze-updates  main contrib non-free/g" /etc/apt/sources.list

#apt-get --yes install python-software-properties
#Adding debian pkgs for adding repo and installing ffmpeg
apt-get --yes install software-properties-common >> $logfile 2>&1
if [ "$OSV11" = "8" ]; then
  apt-add-repository --yes "deb http://www.deb-multimedia.org jessie main non-free" >> $logfile 2>&1
  apt-get update >> $logfile 2>&1
  apt-get --force-yes --yes install ffmpeg >> $logfile 2>&1
fi

echo -e "\033[0;32;148m.....\033[39m"
# 7.
# update and upgrade packages
apt-get --yes install python-software-properties software-properties-common >> $logfile 2>&1
if [ "$OSV1" = "14.04" ] || [ "$OSV1" = "15.04" ] || [ "$OSV1" = "15.10" ] || [ "$OSV1" = "14.10" ]; then
  apt-add-repository --yes ppa:kirillshkrogalev/ffmpeg-next >> $logfile 2>&1
fi
apt-get --yes update >> $logfile 2>&1
apt-get --yes upgrade >> $logfile 2>&1
# 8.
#install all needed packages
apt-get --yes install apache2 apache2-utils autoconf build-essential ca-certificates comerr-dev curl cfv quota mktorrent dtach htop irssi libapache2-mod-php5 libcloog-ppl-dev libcppunit-dev libcurl3 libcurl4-openssl-dev libncurses5-dev libterm-readline-gnu-perl libsigc++-2.0-dev libperl-dev openvpn libssl-dev libtool libxml2-dev ncurses-base ncurses-term ntp openssl patch libc-ares-dev pkg-config php5 php5-cli php5-dev php5-curl php5-geoip php5-mcrypt php5-gd php5-xmlrpc pkg-config python-scgi screen ssl-cert subversion texinfo unzip zlib1g-dev expect flex bison debhelper binutils-gold libarchive-zip-perl libnet-ssleay-perl libhtml-parser-perl libxml-libxml-perl libjson-perl libjson-xs-perl libxml-libxslt-perl libxml-libxml-perl libjson-rpc-perl libarchive-zip-perl tcpdump >> $logfile 2>&1
if [ $? -gt 0 ]; then
  set +x verbose
  echo
  echo
  echo *** ERROR ***
  echo
  echo "Looks like something is wrong with apt-get install, aborting."
  echo
  echo  "You do not have git installed. "
  echo  "Do :   apt-get update && apt-get install git "
  echo  " Then run script again. "
  set -e
  exit 1
fi
apt-get --yes install zip >> $logfile 2>&1

apt-get --yes install ffmpeg >> $logfile 2>&1
apt-get --yes install automake1.9 >> $logfile 2>&1

apt-get --force-yes --yes install rar
if [ $? -gt 0 ]; then
  apt-get --yes install rar-free
fi

#apt-get --yes install unrar
#if [ $? -gt 0 ]; then
#  apt-get --yes install unrar-free
#fi
#if [ "$OSV11" = "8" ]; then
#  apt-get --yes install unrar-free >> $logfile 2>&1
#fi

apt-get --yes install dnsutils >> $logfile 2>&1

if [ "$CHROOTJAIL1" = "YES" ]; then
  cd /etc/seedbox-from-scratch
  tar xvfz jailkit-2.15.tar.gz -C /etc/seedbox-from-scratch/source/
  cd source/jailkit-2.15
  ./debian/rules binary
  cd ..
  dpkg -i jailkit_2.15-1_*.deb
fi

echo -e "\033[0;32;148mGo make coffee......\033[39m"
# 8.1 additional packages for Ubuntu
# this is better to be apart from the others
apt-get --yes install php5-fpm >> $logfile 2>&1
apt-get --yes install php5-xcache libxml2-dev >> $logfile 2>&1

if [ "$OSV1" = "13.10" ]; then
  apt-get install php5-json
fi

#Check if its Debian and do a sysvinit by upstart replacement:
#Commented the follwoing three lines for testing
#if [ "$OS1" = "Debian" ]; then
#  echo 'Yes, do as I say!' | apt-get -y --force-yes install upstart
#fi

# 8.3 Generate our lists of ports and RPC and create variables

#permanently adding scripts to PATH to all users and root
echo "PATH=$PATH:/etc/seedbox-from-scratch:/sbin" | tee -a /etc/profile > /dev/null
echo "export PATH" | tee -a /etc/profile > /dev/null
echo "PATH=$PATH:/etc/seedbox-from-scratch:/sbin" | tee -a /root/.bashrc > /dev/null
echo "export PATH" | tee -a /root/.bashrc > /dev/null

rm -f /etc/seedbox-from-scratch/ports.txt
for i in $(seq 51101 51999)
do
  echo "$i" | tee -a /etc/seedbox-from-scratch/ports.txt > /dev/null
done

rm -f /etc/seedbox-from-scratch/rpc.txt
for i in $(seq 2 1000)
do
  echo "RPC$i"  | tee -a /etc/seedbox-from-scratch/rpc.txt > /dev/null
done

# 8.4

if [ "$INSTALLWEBMIN1" = "YES" ]; then
  #if webmin isup, download key
  WEBMINDOWN=YES
  ping -c1 -w2 www.webmin.com > /dev/null
  if [ $? = 0 ] ; then
    wget -t 5 http://www.webmin.com/jcameron-key.asc >> $logfile 2>&1
    apt-key add jcameron-key.asc >> $logfile 2>&1
    if [ $? = 0 ] ; then
      WEBMINDOWN=NO
    fi
  fi

  if [ "$WEBMINDOWN"="NO" ] ; then
    #add webmin source
    echo "" | tee -a /etc/apt/sources.list > /dev/null
    echo "deb http://download.webmin.com/download/repository sarge contrib" | tee -a /etc/apt/sources.list > /dev/null
    cd /tmp
  fi

  if [ "$WEBMINDOWN" = "NO" ]; then
    apt-get --yes update >> $logfile 2>&1
    apt-get --yes install webmin >> $logfile 2>&1
  fi
fi

if [ "$INSTALLFAIL2BAN1" = "YES" ]; then
  apt-get --yes install fail2ban >> $logfile 2>&1
  cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.original
  cp /etc/seedbox-from-scratch/etc.fail2ban.jail.conf.template /etc/fail2ban/jail.conf
  touch /etc/fail2ban/fail2ban.local
  echo "[description]" | tee -a /etc/fail2ban/fail2ban.local > /dev/null
  echo "logtarget = /var/log/fail2ban.log" | tee -a /etc/fail2ban/fail2ban.local > /dev/null
  fail2ban-client reload
fi
echo -e "\033[0;32;148m.........\033[39m"
# 9.
a2enmod ssl >> $logfile 2>&1
a2enmod auth_digest
a2enmod reqtimeout
a2enmod rewrite
#a2enmod scgi ############### if we cant make python-scgi works
#cd /etc/apache2
#rm apache2.conf
#wget --no-check-certificate https://raw.githubusercontent.com/dannyti/sboxsetup/master/apache2.conf
cat /etc/seedbox-from-scratch/add2apache2.conf >> /etc/apache2/apache2.conf
# 10.

#remove timeout if  there are any
perl -pi -e "s/^Timeout [0-9]*$//g" /etc/apache2/apache2.conf

echo "" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "#seedbox values" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "ServerSignature Off" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "ServerTokens Prod" | tee -a /etc/apache2/apache2.conf > /dev/null
echo "Timeout 30" | tee -a /etc/apache2/apache2.conf > /dev/null
cd /etc/apache2
rm ports.conf
wget --no-check-certificate https://raw.githubusercontent.com/dannyti/sboxsetup/master/ports.conf >> $logfile 2>&1
service apache2 restart
mkdir /etc/apache2/auth.users 

echo "$IPADDRESS1" > /etc/seedbox-from-scratch/hostname.info

# 11.
makepasswd | tee -a /etc/seedbox-from-scratch/sslca.info > /dev/null
export TEMPHOSTNAME1=tsfsSeedBox
export CERTPASS1=@@$TEMPHOSTNAME1.$NEWUSER1.ServerP7s$
export NEWUSER1
export IPADDRESS1

echo "$NEWUSER1" > /etc/seedbox-from-scratch/mainuser.info
echo "$CERTPASS1" > /etc/seedbox-from-scratch/certpass.info

bash /etc/seedbox-from-scratch/createOpenSSLCACertificate >> $logfile 2>&1 

mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -config /etc/seedbox-from-scratch/ssl/CA/caconfig.cnf >> $logfile 2>&1

if [ "$OSV11" = "7" ]; then
  echo "deb http://ftp.cyconet.org/debian wheezy-updates main non-free contrib" >> /etc/apt/sources.list.d/wheezy-updates.cyconet.list
  apt-get update >> $logfile 2>&1
  apt-get install -y --force-yes -t wheezy-updates debian-cyconet-archive-keyring vsftpd libxml2-dev libcurl4-gnutls-dev subversion >> $logfile 2>&1
elif [ "$OSV1" = "12.04" ]; then
  add-apt-repository -y ppa:thefrontiergroup/vsftpd
  apt-get update >> $logfile 2>&1
  apt-get -y install vsftpd >> $logfile 2>&1
else
  apt-get -y install vsftpd >> $logfile 2>&1
fi


#if [ "$OSV1" = "12.04" ]; then
#  dpkg -i /etc/seedbox-from-scratch/vsftpd_2.3.2-3ubuntu5.1_`uname -m`.deb
#fi

perl -pi -e "s/anonymous_enable\=YES/\#anonymous_enable\=YES/g" /etc/vsftpd.conf
perl -pi -e "s/connect_from_port_20\=YES/#connect_from_port_20\=YES/g" /etc/vsftpd.conf
perl -pi -e 's/rsa_private_key_file/#rsa_private_key_file/' /etc/vsftpd.conf
perl -pi -e 's/rsa_cert_file/#rsa_cert_file/' /etc/vsftpd.conf
#perl -pi -e "s/rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem/#rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem/g" /etc/vsftpd.conf
#perl -pi -e "s/rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key/#rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key/g" /etc/vsftpd.conf
echo "listen_port=$NEWFTPPORT1" | tee -a /etc/vsftpd.conf >> /dev/null
echo "ssl_enable=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "allow_anon_ssl=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "force_local_data_ssl=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "force_local_logins_ssl=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "ssl_tlsv1=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "ssl_sslv2=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "ssl_sslv3=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "require_ssl_reuse=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "ssl_ciphers=HIGH" | tee -a /etc/vsftpd.conf >> /dev/null
echo "rsa_cert_file=/etc/ssl/private/vsftpd.pem" | tee -a /etc/vsftpd.conf >> /dev/null
echo "local_enable=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "write_enable=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "local_umask=022" | tee -a /etc/vsftpd.conf >> /dev/null
echo "chroot_local_user=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "chroot_list_file=/etc/vsftpd.chroot_list" | tee -a /etc/vsftpd.conf >> /dev/null
echo "passwd_chroot_enable=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "allow_writeable_chroot=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "seccomp_sandbox=NO" | tee -a /etc/vsftpd.conf >> /dev/null
echo "dual_log_enable=YES" | tee -a /etc/vsftpd.conf >> /dev/null
echo "syslog_enable=NO" | tee -a /etc/vsftpd.conf >> /dev/null
#sed -i '147 d' /etc/vsftpd.conf
#sed -i '149 d' /etc/vsftpd.conf
touch /var/log/vsftpd.log

apt-get install --yes subversion >> $logfile 2>&1
apt-get install --yes dialog >> $logfile 2>&1
# 13.

if [ "$OSV1" = "14.04" ] || [ "$OSV1" = "14.10" ] || [ "$OSV1" = "15.04" ] || [ "$OSV1" = "15.10" ] || [ "$OSV11" = "8" ]; then
  cp /var/www/html/index.html /var/www/index.html 
  mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.ORI
  rm -f /etc/apache2/sites-available/000-default.conf
  cp /etc/seedbox-from-scratch/etc.apache2.default.template /etc/apache2/sites-available/000-default.conf
  perl -pi -e "s/http\:\/\/.*\/rutorrent/http\:\/\/$IPADDRESS1\/rutorrent/g" /etc/apache2/sites-available/000-default.conf
  perl -pi -e "s/<servername>/$IPADDRESS1/g" /etc/apache2/sites-available/000-default.conf
  perl -pi -e "s/<username>/$NEWUSER1/g" /etc/apache2/sites-available/000-default.conf
else
  mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default.ORI
  rm -f /etc/apache2/sites-available/default
  cp /etc/seedbox-from-scratch/etc.apache2.default.template /etc/apache2/sites-available/default
  perl -pi -e "s/http\:\/\/.*\/rutorrent/http\:\/\/$IPADDRESS1\/rutorrent/g" /etc/apache2/sites-available/default
  perl -pi -e "s/<servername>/$IPADDRESS1/g" /etc/apache2/sites-available/default
  perl -pi -e "s/<username>/$NEWUSER1/g" /etc/apache2/sites-available/default
fi
#mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default.ORI
#rm -f /etc/apache2/sites-available/default
#cp /etc/seedbox-from-scratch/etc.apache2.default.template /etc/apache2/sites-available/default
#perl -pi -e "s/http\:\/\/.*\/rutorrent/http\:\/\/$IPADDRESS1\/rutorrent/g" /etc/apache2/sites-available/default
#perl -pi -e "s/<servername>/$IPADDRESS1/g" /etc/apache2/sites-available/default
#perl -pi -e "s/<username>/$NEWUSER1/g" /etc/apache2/sites-available/default

echo "ServerName $IPADDRESS1" | tee -a /etc/apache2/apache2.conf > /dev/null
echo -e "\033[0;32;148mHow was the coffee ?\033[39m"
# 14.
a2ensite default-ssl
#ln -s /etc/apache2/mods-available/scgi.load /etc/apache2/mods-enabled/scgi.load
#service apache2 restart
#apt-get --yes install libxmlrpc-core-c3-dev

#14.1 Download xmlrpc, rtorrent & libtorrent for 0.9.4
#cd
#svn co https://svn.code.sf.net/p/xmlrpc-c/code/stable /etc/seedbox-from-scratch/source/xmlrpc
cd /etc/seedbox-from-scratch/
#wget -c http://libtorrent.rakshasa.no/downloads/rtorrent-0.9.4.tar.gz
#wget -c http://libtorrent.rakshasa.no/downloads/libtorrent-0.13.4.tar.gz
wget -c http://rtorrent.net/downloads/rtorrent-0.9.4.tar.gz >> $logfile 2>&1
wget -c http://rtorrent.net/downloads/libtorrent-0.13.4.tar.gz >> $logfile 2>&1
wget -c http://rtorrent.net/downloads/rtorrent-0.9.6.tar.gz >> $logfile 2>&1 
wget -c http://rtorrent.net/downloads/libtorrent-0.13.6.tar.gz >> $logfile 2>&1

#configure & make xmlrpc BASED ON RTORRENT VERSION
if [ "$RTORRENT1" = "0.9.4" ] || [ "$RTORRENT1" = "0.9.6" ]; then
  tar xvfz /etc/seedbox-from-scratch/xmlrpc-c-1.33.17.tgz -C /etc/seedbox-from-scratch/ >> $logfile 2>&1
  cd /etc/seedbox-from-scratch/xmlrpc-c-1.33.17
  ./configure --prefix=/usr --enable-libxml2-backend --disable-libwww-client --disable-wininet-client --disable-abyss-server --disable-cgi-server >> $logfile 2>&1
  make -j$(grep -c ^processor /proc/cpuinfo) >> $logfile 2>&1
  make install >> $logfile 2>&1
else
  tar xvfz /etc/seedbox-from-scratch/xmlrpc-c-1.16.42.tgz -C /etc/seedbox-from-scratch/source/ >> $logfile 2>&1
  cd /etc/seedbox-from-scratch/source/
  unzip ../xmlrpc-c-1.31.06.zip >> $logfile 2>&1
  cd xmlrpc-c-1.31.06
  ./configure --prefix=/usr --enable-libxml2-backend --disable-libwww-client --disable-wininet-client --disable-abyss-server --disable-cgi-server >> $logfile 2>&1
  make -j$(grep -c ^processor /proc/cpuinfo) >> $logfile 2>&1
  make install >> $logfile 2>&1
fi
# 15.


# 16.
#cd xmlrpc-c-1.16.42 ### old, but stable, version, needs a missing old types.h file
#ln -s /usr/include/curl/curl.h /usr/include/curl/types.h


# 21.
echo -e "\033[0;32;148mDo not give up on me.........Still Working....\033[39m"
bash /etc/seedbox-from-scratch/installRTorrent $RTORRENT1 >> $logfile 2>&1

######### Below this /var/www/rutorrent/ has been replaced with /var/www/rutorrent for Ubuntu 14.04

# 22.
cd /var/www/
rm -f -r rutorrent
svn checkout https://github.com/Novik/ruTorrent/trunk rutorrent >> $logfile 2>&1
#svn checkout http://rutorrent.googlecode.com/svn/trunk/plugins
#rm -r -f rutorrent/plugins
#mv plugins rutorrent/

cp /etc/seedbox-from-scratch/action.php.template /var/www/rutorrent/plugins/diskspace/action.php

groupadd admin

echo "www-data ALL=(root) NOPASSWD: /usr/sbin/repquota" | tee -a /etc/sudoers > /dev/null

cp /etc/seedbox-from-scratch/favicon.ico /var/www/

# 26. Installing Mediainfo from source
apt-get install --yes mediainfo
if [ $? -gt 0 ]; then
  cd /tmp
  wget http://downloads.sourceforge.net/mediainfo/MediaInfo_CLI_0.7.56_GNU_FromSource.tar.bz2 >> $logfile 2>&1
  tar jxvf MediaInfo_CLI_0.7.56_GNU_FromSource.tar.bz2 >> $logfile 2>&1
  cd MediaInfo_CLI_GNU_FromSource/
  sh CLI_Compile.sh >> $logfile 2>&1
  cd MediaInfo/Project/GNU/CLI
  make install >> $logfile 2>&1
fi

cd /var/www/rutorrent/js/
git clone https://github.com/gabceb/jquery-browser-plugin.git >> $logfile 2>&1
mv jquery-browser-plugin/dist/jquery.browser.js .
rm -r -f jquery-browser-plugin
sed -i '31i\<script type=\"text/javascript\" src=\"./js/jquery.browser.js\"></script> ' /var/www/rutorrent/index.html

cd /var/www/rutorrent/plugins
git clone https://github.com/autodl-community/autodl-rutorrent.git autodl-irssi >> $logfile 2>&1
#cp autodl-irssi/_conf.php autodl-irssi/conf.php
#svn co https://svn.code.sf.net/p/autodl-irssi/code/trunk/rutorrent/autodl-irssi/
cd autodl-irssi


# 30. 
cp /etc/jailkit/jk_init.ini /etc/jailkit/jk_init.ini.original
echo "" | tee -a /etc/jailkit/jk_init.ini >> /dev/null
bash /etc/seedbox-from-scratch/updatejkinit >> $logfile 2>&1

# 31. ZNC
#Have put this in script form

# 32. Installing poweroff button on ruTorrent
cd /var/www/rutorrent/plugins/
wget http://rutorrent-logoff.googlecode.com/files/logoff-1.0.tar.gz >> $logfile 2>&1
tar -zxf logoff-1.0.tar.gz >> $logfile 2>&1
rm -f logoff-1.0.tar.gz

#33. Tuning Part - Let me know if you find more.
echo "vm.swappiness=1"  >>/etc/sysctl.conf
echo "net.core.somaxconn = 1000" >>/etc/sysctl.conf
echo "net.core.netdev_max_backlog = 5000" >>/etc/sysctl.conf
echo "net.core.rmem_max = 16777216" >>/etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >>/etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 12582912 16777216" >>/etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 4096 12582912 16777216" >>/etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 8096" >>/etc/sysctl.conf
echo "net.ipv4.tcp_slow_start_after_idle = 0" >>/etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >>/etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 10240 65535" >>/etc/sysctl.conf
echo "fs.file-max = 500000" >>/etc/sysctl.conf
echo vm.min_free_kbytes=1024 >> /etc/sysctl.conf
echo "session required pam_limits.so" >>/etc/pam.d/common-session
echo "net.ipv4.tcp_low_latency=1" >> /etc/sysctl.conf
echo "nnet.ipv4.tcp_sack = 1" >> /etc/sysctl.conf
sysctl -p

if [ -f /proc/user_beancounters ] || [ -d /proc/bc ]; then
  echo "Its a VPS, Nothing to do here, Continuing...."
else
  sed -i "s/defaults        1 1/defaults,noatime        0 0/" /etc/fstab
fi

# Installing Filemanager and MediaStream
rm -f -R /var/www/rutorrent/plugins/filemanager
rm -f -R /var/www/rutorrent/plugins/fileupload
rm -f -R /var/www/rutorrent/plugins/mediastream
rm -f -R /var/www/stream
echo -e "\033[0;32;148mNo kidding.... Did you make coffee ?\033[39m"
cd /var/www/rutorrent/plugins/
svn co http://svn.rutorrent.org/svn/filemanager/trunk/mediastream >> $logfile 2>&1

cd /var/www/rutorrent/plugins/
svn co http://svn.rutorrent.org/svn/filemanager/trunk/filemanager >> $logfile 2>&1

cp /etc/seedbox-from-scratch/rutorrent.plugins.filemanager.conf.php.template /var/www/rutorrent/plugins/filemanager/conf.php

mkdir -p /var/www/stream/
ln -s /var/www/rutorrent/plugins/mediastream/view.php /var/www/stream/view.php
chown www-data: /var/www/stream
chown www-data: /var/www/stream/view.php

echo "<?php \$streampath = 'http://$IPADDRESS1/stream/view.php'; ?>" | tee /var/www/rutorrent/plugins/mediastream/conf.php > /dev/null

# 32.2 # FILEUPLOAD
cd /var/www/rutorrent/plugins/
svn co http://svn.rutorrent.org/svn/filemanager/trunk/fileupload >> $logfile 2>&1
chmod 775 /var/www/rutorrent/plugins/fileupload/scripts/upload
apt-get --yes -f install >> $logfile 2>&1
rm /var/www/rutorrent/plugins/unpack/conf.php
# 32.2
chown -R www-data:www-data /var/www/rutorrent
chmod -R 755 /var/www/rutorrent

#32.3
perl -pi -e "s/\\\$topDirectory\, \\\$fm/\\\$homeDirectory\, \\\$topDirectory\, \\\$fm/g" /var/www/rutorrent/plugins/filemanager/flm.class.php
perl -pi -e "s/\\\$this\-\>userdir \= addslash\(\\\$topDirectory\)\;/\\\$this\-\>userdir \= \\\$homeDirectory \? addslash\(\\\$homeDirectory\) \: addslash\(\\\$topDirectory\)\;/g" /var/www/rutorrent/plugins/filemanager/flm.class.php
perl -pi -e "s/\\\$topDirectory/\\\$homeDirectory/g" /var/www/rutorrent/plugins/filemanager/settings.js.php

#32.4
#unzip /etc/seedbox-from-scratch/rutorrent-oblivion.zip -d /var/www/rutorrent/plugins/
#echo "" | tee -a /var/www/rutorrent/css/style.css > /dev/null
#echo "/* for Oblivion */" | tee -a /var/www/rutorrent/css/style.css > /dev/null
#echo ".meter-value-start-color { background-color: #E05400 }" | tee -a /var/www/rutorrent/css/style.css > /dev/null
#echo ".meter-value-end-color { background-color: #8FBC00 }" | tee -a /var/www/rutorrent/css/style.css > /dev/null
#echo "::-webkit-scrollbar {width:12px;height:12px;padding:0px;margin:0px;}" | tee -a /var/www/rutorrent/css/style.css > /dev/null
perl -pi -e "s/\$defaultTheme \= \"\"\;/\$defaultTheme \= \"Oblivion\"\;/g" /var/www/rutorrent/plugins/theme/conf.php
git clone https://github.com/InAnimaTe/rutorrent-themes.git /var/www/rutorrent/plugins/theme/themes/Extra >> $logfile 2>&1
cp -r /var/www/rutorrent/plugins/theme/themes/Extra/OblivionBlue /var/www/rutorrent/plugins/theme/themes/
cp -r /var/www/rutorrent/plugins/theme/themes/Extra/Agent46 /var/www/rutorrent/plugins/theme/themes/
rm -r /var/www/rutorrent/plugins/theme/themes/Extra
#ln -s /etc/seedbox-from-scratch/seedboxInfo.php.template /var/www/seedboxInfo.php

# 32.5
cd /var/www/rutorrent/plugins/
rm -r /var/www/rutorrent/plugins/fileshare
rm -r /var/www/share
svn co http://svn.rutorrent.org/svn/filemanager/trunk/fileshare >> $logfile 2>&1
mkdir /var/www/share
ln -s /var/www/rutorrent/plugins/fileshare/share.php /var/www/share/share.php
ln -s /var/www/rutorrent/plugins/fileshare/share.php /var/www/share/index.php
chown -R www-data:www-data /var/www/share
cp /etc/seedbox-from-scratch/rutorrent.plugins.fileshare.conf.php.template /var/www/rutorrent/plugins/fileshare/conf.php
perl -pi -e "s/<servername>/$IPADDRESS1/g" /var/www/rutorrent/plugins/fileshare/conf.php

mv /etc/seedbox-from-scratch/unpack.conf.php /var/www/rutorrent/plugins/unpack/conf.php

# 33.
echo -e "\033[0;32;148m.................\033[39m"
bash /etc/seedbox-from-scratch/updateExecutables >> $logfile 2>&1

#34.
echo $SBFSCURRENTVERSION1 > /etc/seedbox-from-scratch/version.info
echo $NEWFTPPORT1 > /etc/seedbox-from-scratch/ftp.info
echo $NEWSSHPORT1 > /etc/seedbox-from-scratch/ssh.info
echo $OPENVPNPORT1 > /etc/seedbox-from-scratch/openvpn.info

# 36.
wget -P /usr/share/ca-certificates/ --no-check-certificate https://certs.godaddy.com/repository/gd_intermediate.crt https://certs.godaddy.com/repository/gd_cross_intermediate.crt 
update-ca-certificates >> $logfile 2>&1
c_rehash >> $logfile 2>&1

sleep 2

# 96.
if [ "$INSTALLOPENVPN1" = "YES" ]; then
  bash /etc/seedbox-from-scratch/installOpenVPN
fi

if [ "$INSTALLSABNZBD1" = "YES" ]; then
  bash /etc/seedbox-from-scratch/installSABnzbd
fi

if [ "$INSTALLRAPIDLEECH1" = "YES" ]; then
  bash /etc/seedbox-from-scratch/installRapidleech
fi

if [ "$INSTALLDELUGE1" = "YES" ]; then
  bash /etc/seedbox-from-scratch/installDeluge
fi

sleep 1

# 97. First user will not be jailed
echo -e "\033[0;32;148mLeave it now, About to Finish........\033[39m"
#  createSeedboxUser <username> <password> <user jailed?> <ssh access?> <Chroot User>
bash /etc/seedbox-from-scratch/createSeedboxUser $NEWUSER1 $PASSWORD1 YES YES YES NO >> $logfile 2>&1

#Loadavg
cd ~
git clone https://github.com/loadavg/loadavg.git >> $logfile 2>&1
cd loadavg
cd ~
mv loadavg /var/www/
cd /var/www/loadavg
chmod 777 configure
./configure >> $logfile 2>&1

cd ~
wget -qO ~/unrar.tar.gz http://www.rarlab.com/rar/unrarsrc-5.3.8.tar.gz
sudo tar xf ~/unrar.tar.gz >> $logfile 2>&1
cd ~/unrar
make && make install DESTDIR=~ >> $logfile 2>&1
cd && rm -rf unrar{,.tar.gz}

cd ~
wget --no-check-certificate https://bintray.com/artifact/download/hectortheone/base/pool/m/m/magic/magic.zip >> $logfile 2>&1
unzip magic.zip >> $logfile 2>&1
mv default.sfx rarreg.key /usr/local/lib/
rm magic.zip

cd /var/www
chown -R www-data:www-data /var/www/rutorrent
chown -R www-data:www-data /var/www/loadavg
chmod -R 755 /var/www/rutorrent
cd 
git clone https://github.com/mcrapet/plowshare.git plowshare >> $logfile 2>&1
cd ~/plowshare
make install >> $logfile 2>&1
cd
rm -r plowshare

export EDITOR=nano
# 100
cd /var/www/rutorrent/plugins
sleep 1
rm -frv diskspace
wget --no-check-certificate https://bintray.com/artifact/download/hectortheone/base/pool/main/b/base/hectortheone.rar >> $logfile 2>&1
#wget http://dl.bintray.com/novik65/generi...ace-3.6.tar.gz
#tar -xf diskspace-3.6.tar.gz
unrar x hectortheone.rar >> $logfile 2>&1
#rm diskspace-3.6.tar.gz
rm hectortheone.rar
cd quotaspace
chmod 755 run.sh
cd ..
perl -pi -e "s/100/1024/g" /var/www/rutorrent/plugins/throttle/throttle.php
#wget --no-check-certificate http://cheapseedboxes.com/trafic_check.rar >> $logfile 2>&1
#unrar x trafic_check.rar >> $logfile 2>&1
#rm trafic_check.rar
#wget --no-check-certificate http://cheapseedboxes.com/plimits.rar >> $logfile 2>&1
#unrar x plimits.rar >> $logfile 2>&1
#rm plimits.rar
#cd ..
chown -R www-data:www-data /var/www/rutorrent
echo -e "\033[0;32;148mFinishing Now .... .... .... ....\033[39m"
#wget http://www.rarlab.com/rar/unrarsrc-5.3.8.tar.gz
#tar -xvf unrarsrc-5.3.8.tar.gz
#cd unrar
#sudo make -f makefile
#sudo install -v -m755 unrar /usr/bin
#cd ..
#rm -R unrar
#rm unrarsrc-5.3.8.tar.gz

if [ "$OSV11" = "8" ]; then
  systemctl enable apache2
  service apache2 start 
fi
#set +x verbose
#clear

echo ""
echo -e "\033[0;32;148m<<< The Seedbox From Scratch Script >>>\033[39m"
echo -e "\033[0;32;148mScript Modified by dannyti ---> https://github.com/dannyti/\033[39m"
echo ""
echo "Looks like everything is set."
echo ""
echo "Remember that your SSH port is now ======> $NEWSSHPORT1 "
echo ""
echo "Your Login info can also be found at https://$IPADDRESS1/private/SBinfo.txt"
echo "Download Data Directory is located at https://$IPADDRESS1/private "
echo "To install ZNC, run installZNC from ssh as main user"
echo ""
echo "IMPORTANT NOTE: Refresh rutorrent for Throttle plugin to load properly"
echo ""
echo "System will reboot now, but don't close this window until you take note of the port number: $NEWSSHPORT1"
echo ""
#echo -e "\033[0;32;148mPlease login as main user and only then close this Window\033[39m"

#reboot

##################### LAST LINE ###########

