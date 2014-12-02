#!/usr/bin/env sh

MESSAGE="standby ros_xdotool_string_sub.sh";
rostopic pub -1 /ros_xdotool/command/string std_msgs/String "$MESSAGE";
echo $MESSAGE;

rostopic echo "/ros_xdotool/command/string" | while read line ;
do
    if [ "`echo $line | grep -`" ];
    then
        ## implement here
        BUF=`echo $BUF | sed "s/^\ *data\:\ \(.\+\)\ *$/\\1/g"`;
        echo  "[ros_xdotool_string_sub] receive message: $BUF";
	eval "$BUF";
        ##
        BUF="";
    else
        BUF="$BUF $line";
    fi
done
