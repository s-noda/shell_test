#!/usr/bin/env bash

f=`arp -n | grep $1`;

if [ "$f" ];
then
    echo $f;
else
    i=0;
    while [ "$i" -lt "255" ];
    do
	i=`expr $i + 1`;
	ping 192.168.97.$i &
    done

    sleep 3;
    pkill ping;
    f=`arp -n | grep $1`;
    echo $f;
fi
