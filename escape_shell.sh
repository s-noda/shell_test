#!/usr/bin/env sh

## sudo aptitude install wmctrl;
## sudo apt-get install xautomation

PS1="\[\033[01;32m\]escape_shell\[\033[00m\]\$ ";
WIN=`echo \`pwd\` | sed -e "s/\\//\\\\n/g" | tail -1`;
WIN=`wmctrl -l | grep $WIN | tail -1 | sed -e "s/\ /\\n/g" | head -1`;

DEF_CMD="wmctrl -i -r $WIN -e 0,";

PARAM_X="0";
PARAM_Y="0";
PARAM_W="500";
PARAM_H="70";

while [ "true" ];
do
    PARAM_X=`xmousepos | sed -e "s/\ /\\n/g" | head -1`;
    PARAM_X=`expr $PARAM_X + 100`;
    PARAM_Y=`xmousepos | sed -e "s/\ /\\n/g" | head -2 | tail -1`;
    CMD="${DEF_CMD}${PARAM_X},${PARAM_Y},${PARAM_W},${PARAM_H}";
    echo -e "\e[1;32m $CMD \e[m";
    echo $CMD | /bin/sh;
    ## sleep 1;
    `which eus` "(progn (unix:usleep 100000) (exit))" 2> /dev/null
done;


