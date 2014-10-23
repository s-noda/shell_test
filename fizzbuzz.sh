#!/usr/bin/env sh

function fizzbuzz(){
    RET="";
    if [ "`expr $1 % 3`" == "0" ];
    then
        RET="${RET}FIZZ";
    fi
    if [ "`expr $1 % 5`" == "0" ];
    then
        RET="${RET}BUZZ";
    fi
    if [ ! "$RET" ];
    then
        RET=$1;
    fi
    echo $RET;
}

function fizzbuzz_test(){
    TMP=0;
    while [ "true" ];
    do
        TMP=`expr $TMP + 1`;
        echo -n "[$TMP] ";
        fizzbuzz $TMP;
        sleep 1;
    done
}
