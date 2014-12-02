#!/usr/bin/env sh

MESSAGE="standby ros_xdotool_click_sub.sh";
rostopic pub -1 /ros_xdotool/click/button std_msgs/Int32 "{data: 1}";
echo $MESSAGE;

rostopic echo "/ros_xdotool/click/button" | while read line ;
do
    if [ "`echo $line | grep data\:`" ];
    then
	BUF=`echo $line | sed "s/^\ *data\:\ \(.\+\)\ *$/\\1/g"`;
	echo  "[ros_xdotool_click_sub] receive message: $BUF";
	CMD="xdotool click $BUF";
	eval "$CMD";
    fi;
done
