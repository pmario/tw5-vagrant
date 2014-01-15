#!/bin/sh
# this line adds the autostart commands to rc.local

sed -i '/exit 0/c\csh -cf "/usr/bin/svscanboot &"\
exit 0' /etc/rc.local
