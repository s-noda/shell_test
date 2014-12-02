#!/usr/bin/env sh

MESSAGE="standby ros_xdotool_mouse_move_sub.sh";
## rostopic pub -1 /ros_xdotool/mouse_move/vector std_msgs/Float32MultiArray "{data: [0,0]}";
echo $MESSAGE;

rostopic echo "/ros_xdotool/mouse_move/vector" | while read line ;
do
    if [ "`echo $line | grep data\:`" ];
    then
	BUF=`echo $line | sed "s/^\ *data\:\ \(.\+\)\ *$/\\1/g"`;
	echo  "[ros_xdotool_mouse_move_sub] receive message: $BUF";
	CNT=0;
	CMD="xdotool mousemove ";
	for val in `echo "$BUF" | sed "s/\[\|\]//g" | sed "s/[\,\|\ ]\+/\ /g"`;
	do
	    CMD="$CMD $val";
	    CNT=`expr $CNT + 1`;
	done;
	if [ "$CNT" -eq "2" ];
	then
	    eval "$CMD";
	else
	    echo -e " \e[1;31minvalid vector command length $CNT\e[m";
	fi
    fi;
done
