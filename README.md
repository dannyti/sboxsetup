Sboxsetup

By dannyti ---> https://github.com/dannyti/

Donate if you can - Beer Joint Address : Bitcoin address: 1ACi4NRpfzkCNDaTgwFpCFcHoMMRCCT4wC

Intends to install sbox without errors alongwith crontab entries to restart services on reboots. 
This will properly populate tracker list for autodl. Make crontab entries for the user to restart rtorrent on reboots and check whether it's running every 2 mins. 
This script will also eliminate the msie browser errors due to jQuery updates. 
Other aesthetic corrections done as well.
Adding new themes to it : Agent46 & Oblivion blue.

Latest: Proper chroot specified users 

Latest: Site wide http redirects to https, More secure environment.

Latest: Added following for Multi User environment: 

Individual Login info:  https://Server-IP/private/SBinfo.txt 

Individual Data Download directory:  https://Server-IP/private/Downloads

OpenVPN Fixed

This script has the following features

    A multi-user enviroment, you'll have scripts to add and delete users.
    Linux Quota, to control how much space every user can use in your box.
    Individual User Login Info https://Server-IP/private/SBinfo.txt
    Individual User Https Downloads directory (https://Server-IP/private/Downloads)

Installed software

    ruTorrent 3.7 + official plugins
    rTorrent 0.9.2 or 0.9.3 or 0.9.4(you can choose)
    Deluge 1.3.5 or 0.9.3 (you can choose, downgrade and upgrade at any time)
    libTorrrent 0.13.2 or 0.12.9
    mktorrent
    Fail2ban - to avoid apache and ssh exploits. Fail2ban bans IPs that show malicious signs -- too many password failures, seeking for exploits, etc.
    Apache (SSL)
    OpenVPN - Fixed
    ZNC Latest - To install it - Wait for script completion and reboot, after reboot you must run "installZNC" as main user and set it up
    PHP 5 and PHP-FPM (FastCGI to increase performance)
    Linux Quota
    SSH Server (for SSH terminal and sFTP connections)
    vsftpd (Very Secure FTP Deamon) <-- Working
    IRSSI
    Webmin (use it to manage your users quota)
    sabnzbd: http://sabnzbd.org/
    Rapidleech (http://www.rapidleech.com)

Main ruTorrent plugins

autotoolscpuload, diskspace, erasedata, extratio, extsearch, feeds, filedrop, filemanager, geoip, history, logoff, mediainfo, mediastream, rss, scheduler, screenshots, theme, trafic and unpack
Additional ruTorrent plugins

    Autodl-IRSSI (with an updated list of trackers)
    A modified version of Diskpace to support quota (by Notos)
    Filemanager (modified to handle rar, zip, unzip, tar and bzip)
    Fileupload
    Fileshare Plugin (http://forums.rutorrent.org/index.php?topic=705.0)
    MediaStream (to watch your videos right from your seedbox)
    Logoff
    Theme: Oblivion & Agent 46

Before installation

You need to have a Fresh "blank" server installation. After that access your box using a SSH client, like PuTTY.
Warnings
If you don't know Linux ENOUGH:

DO NOT install this script on a non OVH Host. It is doable, but you'll have to know Linux to solve some problems.

DO NOT use capital letters, all your usernames should be written in lowercase.

DO NOT upgrade anything in your box, ask in the thread before even thinking about it.

DO NOT try to reconfigure packages using other tutorials.
How to install

That is the question you must ask yourself.
You must be logged in as root to run this installation or use sudo on it.
Commands

After installing you will have access to the following commands to be used directly in terminal

    createSeedboxUser
    deleteSeedboxUser
    changeUserPassword
    installRapidleech
    installOpenVPN
    installSABnzbd
    installWebmin
    updategitRepository
    removeWebmin
    installRTorrent
    installZNC - Let the script complete and reboot, then run this command
    restartSeedbox

    While executing them, if sudo is needed, they will ask for a password.

Services

To access services installed on your new server point your browser to the following address:

https://<Server IP or Server Name>/private/SBinfo.txt

Download Directory

To access Downloaded data directory on your new server; point your browser to the following address:

https://<Server IP or Server Name>/private/Downloads

OpenVPN

To use your VPN you will need a VPN client compatible with OpenVPN, necessary files to configure your connection are in this link in your box:

https://<Server IP or Server Name>/rutorrent/CLIENT-NAME.zip` and use it in any OpenVPN client.

Supported and tested servers

    Ubuntu Server 12.10.0 - 64bit (on VM environment)
    Ubuntu Server 12.04.x - 64bit (on VM environment)
    Ubuntu Server 14.04.x - 32bit (OVH's Kimsufi 2G and 16G - Precise)
    Ubuntu Server 14.04.x - 64bit (OVH's Kimsufi 2G and 16G - Precise)
    Ubuntu Server 14.10 - 32 and 64 bit
    Ubuntu Server 15.04 - 32 and 64 bit
    Debian 6.0.6 - 32 and 64bit (OVH's Kimsufi 2G - Squeeze)
    Debian 6.0.6 - 32 and 64bit (on VM environment)
    Debian 7.0 - 32 and 64 bit
    Debian 8.1 - 32 and 64 bit

Quota

Quota is disabled by default in your box. To enable and use it, you'll have to open Webmin, using the address you can find in one of the tables box above this. After you sucessfully logged on Webmin, enable it by clicking

System => Disk and Network Filesystems => /home => Use Quotas? => Select "Only User" => Save

Now you'll have to configure quota for each user, doing

System => Disk Quotas => /home => => Configure the "Soft kilobyte limit" => Update

As soon as you save it, your seedbox will also update the available space to all your users.
Changelog

Take a look at seedbox-from-scratch.sh and github commit history, it's all there.
Support

There is no real support for this script, but nerds are talking a lot about it here and you may find solutions for your problems in that thread.
License

Copyright (c) 2015 dannyti (https://github.com/dannyti/)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

--> Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

Donate if you can - Beer Joint Address : Bitcoin address: 1ACi4NRpfzkCNDaTgwFpCFcHoMMRCCT4wC
