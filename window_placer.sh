#!/bin/bash

function get_window_id_from_line(){
    ID="ERROR";
    for id in $1;
    do
	ID=$id;
	break;
    done
    echo $ID;
}

function get_window_size_from_line(){
    RET="";
    ID=0;
    ## echo $1;
    for val in $1;
    do
	ID=`expr $ID + 1`;
	if [ "$ID" -gt "6" ];
	then
	    break;
	elif [ "$ID" -gt "2" ];
	then
	    RET="$RET $val";
	fi
	## echo $ID $RET ;
    done
    echo $RET;
}

function get_dnd_size(){
    get_window_size_from_line "`wmctrl -l -G | grep DND | head -1`";
}

function get_window_id_from_string(){
    wmctrl -l | grep $1 | while read line;
    do
	get_window_id_from_line "$line";
    done
}

function get_window_size_from_string(){
    wmctrl -l -G | grep $1 | while read line;
    do
	## echo $line;
	get_window_size_from_line "$line";
    done
}

function get_w_from_window_size(){ echo $3; }
function get_h_from_window_size(){ echo $4; }

function place_windows_from_string(){
    MAXW=`get_dnd_size` ;
    MAXH=`get_h_from_window_size $MAXW`;
    MAXW=`get_w_from_window_size $MAXW`;
    STEPW=300;
    STEPH=300;
    STARTX=70;
    STARTY=30;
    MARGINX=5;
    MARGINY=35;
    if [ "$2" ]; then STEPW=$2; fi;
    if [ "$3" ]; then STEPH=$3; fi;
    if [ "$4" ]; then STARTX=$4; fi;
    if [ "$5" ]; then STARTY=$5; fi;
    if [ "$6" ]; then MARGINX=$6; fi;
    if [ "$7" ]; then MARGINY=$7; fi;
    X=$STARTX;
    Y=$STARTY;
    echo $MAXW $MAXH;
    wmctrl -l -G | grep $1 | while read line;
    do
	ID=`get_window_id_from_line "$line"`;
	RECT=`get_window_size_from_line "$line"`;
	wmctrl -i -r $ID -e 0,$X,$Y,$STEPW,$STEPH;
	X=`expr $X + $STEPW + $MARGINX`;
	if [ "`expr $X + $STEPW`" -gt "$MAXW" ];
	then
	    X=$STARTX;
	    Y=`expr $Y + $STEPH + $MARGINY`;
	fi
    done
}
