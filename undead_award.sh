#!/usr/bin/env bash

CTRC=0;
function hander() {
    CNT=0;
    CTRC=`expr $CTRC + 1`;
    clear;
    while [ "${CTRC}" -gt "${CNT}" ];
    do
        echo -e "\e[31maward is forever!!!!\e[m";
        CNT=`expr $CNT + 1`;
    done
    sleep 0.5;
}

function stop_hander() {
    echo "stop?";
}

function arrow_str() {
    CNT=0;
    RET="";
    while [ "$1" -gt "$CNT" ];
    do
        RET="${RET}-";
        CNT=`expr $CNT + 1`;
    done
    echo "$RET->";
}


## main

trap hander SIGINT
## trap stop_hander SIGTSTP

MAIN_CNT=0;
MAIN_STEP=1;
while [ "true" ];
do
    if [ "${MAIN_CNT}" -gt "30" ];
    then
        MAIN_STEP=-1;
    fi
    if [ "${MAIN_CNT}" -lt "0" ];
    then
        MAIN_STEP=1;
    fi
    MAIN_CNT=`expr $MAIN_CNT + $MAIN_STEP`;
    echo -ne "\\033c\e[32m`arrow_str $MAIN_CNT`award\e[m";
    sleep 0.01;
done
