#!/usr/bin/env bash

black="\e[40m"; ## C000000
red="\e[41m"; ## CFF0000
lime="\e[42m"; ## C00FF00
yellow="\e[43m"; ## CFFFF00
blue="\e[44m"; ## C0000FF
magenta="\e[45m"; ## CFF00FF
cyan="\e[46m"; ## C00FFFF
white="\e[47m"; ## CFFFFFF
CLEAR="\e[m";

IN_PATH="test.png";
if [ "$1" ];
then
    IN_PATH=$1;
fi

function test_paint_colors(){
    echo -e "${black}　${red}　${lime}　${blue}　${yellow}　${magenta}　${cyan}　${white}　${CLEAR}";
}

function convert_image_small(){
    convert -geometry 100x100 -depth 1 $1 /tmp/`basename $1`.bmp;
}

function draw_image(){
    ## set -x;
    IN_PATH="test.png";
    if [ "$1" ];
    then
	IN_PATH=$1;
    fi
    MAX_WIDTH=40;
    MAX_HEIGHT=40;
    if [ "$2" ];
    then
	MAX_WIDTH=$2;
    fi
    if [ "$3" ];
    then
	MAX_HEIGHT=$3;
    fi
    convert -geometry ${MAX_WIDTH}x${MAX_HEIGHT} -depth 1 $IN_PATH /tmp/tmp.png;
    IN_PATH="/tmp/tmp.png";
    WIDTH=`convert $IN_PATH -format '%[width]' info:-`;
    HEIGHT=`convert $IN_PATH -format '%[height]' info:-`;
    OUTPUT="";
    y=0;
    while [ "$y" -lt "$HEIGHT" ];
    do
	x=0;
	DRAW_LINE="";
	## DRAW_LINE="echo -n -e \"";
	while [ "$x" -lt "$WIDTH" ];
	do
	    CMD="convert $IN_PATH -format '%[pixel:p{${x},${y}}]' info:-";
	    rgb=`eval $CMD`;
	    ## echo "$CMD = $rgb";
	    CMD="\${${rgb}}";
	    ## echo $CMD;
	    color=`eval "echo $CMD"`;
	    ## echo -n -e "${color}　${CLEAR}"
	    DRAW_LINE="${DRAW_LINE}${color}　"
	    x=`expr $x + 1`;
	done
	eval "echo -n -e \"${DRAW_LINE}\"";
	echo -e "${CLEAR}";
	y=`expr $y + 1`;
	OUTPUT="${OUTPUT}${DRAW_LINE}${CLEAR}";
	if [ "$y" -lt "$HEIGHT" ];
	then
	    OUTPUT="${OUTPUT}\n";
	fi
    done
    echo -e "${CLEAR}";
    ## echo "${OUTPUT}${CLEAR}";
}

function set_image_PS1(){
    export PS1="`draw_image $@` $ ";
}

test_paint_colors;
echo "paint.sh loaded" ;

## convert test.png -format '%[pixel:p{1920,0}]' info:-
## convert test.png -format '%[width]' info:-
