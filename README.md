# Dropbox Uploader from Linux Server
Dropbox Uploader is a BASH script which can be used to upload, download, delete, list files (and more!) from Dropbox, an online file sharing, synchronization and backup service.

# Getting started
Git clone `https://github.com/danny0x4/dropbox-uploader.git`
Then, enter the directory of `dropbox-uploader`
Then give the execution permission to the script and run it:
`$chmod +x dropbox_uploader.sh
 $./dropbox_uploader.sh`
The first time you run dropbox_uploader, you'll be guided through a wizard in order to configure access to your Dropbox. This configuration will be stored in ~/.dropbox_uploader.
# Usage
`./dropbox_uploader.sh [PARAMETERS] COMMAND...
[%%]: Optional param
<%%>: Required param`

# Examples:
`
    ./dropbox_uploader.sh upload /etc/passwd /myfiles/passwd.old
    ./dropbox_uploader.sh upload *.zip /
    ./dropbox_uploader.sh -x .git upload ./project /
    ./dropbox_uploader.sh download /backup.zip
    ./dropbox_uploader.sh delete /backup.zip
    ./dropbox_uploader.sh mkdir /myDir/
    ./dropbox_uploader.sh upload "My File.txt" "My File 2.txt"
    ./dropbox_uploader.sh share "My File.txt"
    ./dropbox_uploader.sh list
`
# Tested Environments
`
GNU Linux
FreeBSD 8.3/10.0
MacOSX
Windows/Cygwin
Raspberry Pi
QNAP
iOS
OpenWRT
Chrome OS
OpenBSD
Termux
`
# Running as cron job for mysql script automation
` use crontab -e and put the command */10 * * * * /path/to/mysql_script.sh
