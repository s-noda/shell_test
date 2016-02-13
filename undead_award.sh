#!/usr/bin/env bash

CTRC=0;
function hander() {
    CNT=0;
    CTRC=`expr $CTRC + 1`;
    while [ "${CTRC}" -gt "${CNT}" ];
    do
        echo -e "\e[31maward is forever!!!!\e[m";
        CNT=`expr $CNT + 1`;
    done
    sleep 0.5;
}

trap hander SIGINT

while [ "true" ];
do
    for space in "" " " "  " "   " "  " " ";
    do
        echo -ne "\\033c\e[32m${space}award\e[m";
        sleep 0.1;
    done
done
