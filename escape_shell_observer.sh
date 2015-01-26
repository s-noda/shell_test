#!/usr/bin/env sh

## sudo aptitude install wmctrl;
## sudo apt-get install xautomation

rm -rf /tmp/escape_shell.pid;
while [ "true" ];
do
    PID="nothing";
    if [ -e /tmp/escape_shell.pid ];
    then
        PID=`cat /tmp/escape_shell.pid`;
    fi
    if [ "`wmctrl -l | grep $PID;`" ];
    then
        echo "escape_shell detected";
    else
        gnome-terminal -e "bash `pwd`/escape_shell_son.sh";
    fi
    sleep 3;
done


