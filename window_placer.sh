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

