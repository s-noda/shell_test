#!/usr/bin/env sh

INTOPIC="/hoge";
OUTTOPIC="/fuga";

BUF="";

if [ "$1" ];
then
    INTOPIC=$1;
fi
if [ "$2" ];
then
    OUTTOPIC=$2;
fi

rostopic pub -1 $OUTTOPIC std_msgs/String "hoge" > /dev/null;

rostopic echo $INTOPIC | while read line ;
do
    if [ "`echo $line | grep -`" ];
    then
        ## implement here
        BUF=`echo $BUF | sed "s/^\ *data\:\ \(.\+\)\ *$/\\1/g"`;
        echo -n "$BUF($INTOPIC) --> ";
        if [ "$BUF" == "hoge" ];
        then
            BUF="fuga";
        elif [ "$BUF" == "fuga" ];
        then
            BUF="piyo";
        else
            BUF="hoge";
        fi
        echo "$BUF($OUTTOPIC)";
        rostopic pub -1 $OUTTOPIC std_msgs/String $BUF > /dev/null;
        rostopic pub -1 $OUTTOPIC std_msgs/String $BUF > /dev/null;
        rostopic pub -1 $OUTTOPIC std_msgs/String $BUF > /dev/null;
        ##
        BUF="";
    else
        BUF="$BUF $line";
    fi
done
