#!/usr/bin/env sh

## sudo aptitude install wmctrl;

PS1="\[\033[01;32m\]command_line_shell_controller\[\033[00m\]\$ ";
WIN=`echo \`pwd\` | sed -e "s/\\//\\\\n/g" | tail -1`;
WIN=`wmctrl -l | grep $WIN | tail -1 | sed -e "s/\ /\\n/g" | head -1`;

DEF_CMD="wmctrl -i -r $WIN -e 0,";
PARAM_X="60";
PARAM_Y="20";
PARAM_W="-1";
PARAM_H="-1";

CMD="${DEF_CMD}${PARAM_X},${PARAM_Y},${PARAM_W},${PARAM_H}";
echo -e "\e[1;32m $CMD \e[m";
echo $CMD | /bin/sh;

while [ "true" ];
do
    echo "[command line controller]"
    echo -e "\t i: forward";
    echo -e "\t j: left";
    echo -e "\t k: backward";
    echo -e "\t l: right";
    read CMD;
    if [ "$CMD" == "i" ];
    then
        PARAM_Y=`expr $PARAM_Y - 10`;
    elif [ "$CMD" == "j" ]
    then
        PARAM_X=`expr $PARAM_X - 10`;
    elif [ "$CMD" == "k" ]
    then
        PARAM_Y=`expr $PARAM_Y + 10`;
    elif [ "$CMD" == "l" ]
    then
        PARAM_X=`expr $PARAM_X + 10`;
    fi;
    if [ "$CMD" ];
    then
        CMD="${DEF_CMD}${PARAM_X},${PARAM_Y},${PARAM_W},${PARAM_H}";
        echo -e "\e[1;32m $CMD \e[m";
        echo $CMD | /bin/sh;
    fi;
done;


