#!/bin/bash

## sudo aptitude install wmctrl;
## sudo apt-get install xautomation

sleep 1;

PS1="\[\033[01;32m\]escape_shell\[\033[00m\]\$ ";
WIN="Terminal";
WIN=`wmctrl -l | grep $WIN | tail -1 | sed -e "s/\ /\\n/g" | head -1`;

echo $WIN > /tmp/escape_shell.pid;
DEF_CMD="wmctrl -i -r $WIN -e 0,";

PARAM_X="0";
PARAM_Y="0";
PARAM_W="500";
PARAM_H="70";

PARAM_X=`xmousepos | sed -e "s/\ /\\n/g" | head -1`;
PARAM_Y=`xmousepos | sed -e "s/\ /\\n/g" | head -2 | tail -1`;


while [ "true" ];
do
    TMP_PARAM_X=`xmousepos | sed -e "s/\ /\\n/g" | head -1`;
    TMP_PARAM_X=`expr $TMP_PARAM_X + 100`;
    TMP_PARAM_Y=`xmousepos | sed -e "s/\ /\\n/g" | head -2 | tail -1`;
    DIFF_X=`expr $TMP_PARAM_X - $PARAM_X` ;
    DIFF_Y=`expr $TMP_PARAM_Y - $PARAM_Y` ;
    DIFFDIFF=`expr $DIFF_X \* $DIFF_X + $DIFF_Y \* $DIFF_Y`;
    ## if [ "${DIFFDIFF}" -lt "10005" ];
    if [ "true" ] ;
    then
        PARAM_X=$TMP_PARAM_X;
        PARAM_Y=$TMP_PARAM_Y;
        CMD="${DEF_CMD}${PARAM_X},${PARAM_Y},${PARAM_W},${PARAM_H}";
        echo -e "\e[1;32m $CMD \e[m";
        wmctrl -i -R $WIN;
        echo $CMD | /bin/sh;
    else
        echo -e "\e[1;31m ${DIFFDIFF} > 10000 \e[m";
    fi
    ## sleep 1;
    `which eus` "(progn (unix:usleep 100000) (exit))" 2> /dev/null
done;

