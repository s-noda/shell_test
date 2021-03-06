#!/usr/bin/env sh

A=3;
B=5;
MAX=1000;

if [ "$1" ];
then
    A=$1;
fi
if [ "$2" ];
then
    B=$2;
fi
if [ "$3" ];
then
    MAX=$3;
fi

SUM=0;
ID=0;
while [ $ID -lt $MAX ];
do
    if [ "`expr $ID % $A`" == "0" ];
    then
        SUM=`expr $SUM + $ID`;
    elif [ "`expr $ID % $B`" == "0" ];
    then
        SUM=`expr $SUM + $ID`;
    fi
    ID=`expr $ID + 1`;
done
echo "$A or $B multiples in [0, $MAX] = $SUM" ;
