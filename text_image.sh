#!/usr/bin/env bash

function draw_text(){
    TEXT=$1;
    OUTPATH="output.png";
    COLOR=black;
    BGCOLOR=white;
    if [ "$2" ]; then OUTPATH=$2; fi
    if [ "$3" ]; then COLOR=$3; fi
    if [ "$4" ]; then BGCOLOR=$4; fi
    ## if [ ! -e "captcha" ]; then curl -s -A "Mozilla/5" "http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=captcha&dirname=captcha" -o captcha; fi;
    echo -n -e "$TEXT" > /tmp/buf.txt;
    ## convert -background white -fill $COLOR -font '/usr/share/fonts/truetype/fonts-japanese-mincho.ttf' -pointsize 32 label:@/tmp/buf.txt $OUTPATH;
    convert -background $BGCOLOR -fill $COLOR -font '/usr/share/fonts/truetype/fonts-japanese-mincho.ttf' -weight Bold -stroke $COLOR -pointsize 32 label:@/tmp/buf.txt $OUTPATH;
}

function draw_rainbow_text(){
    TEXT=$1;
    OUTPATH="output.png";
    if [ "$2" ]; then OUTPATH=$2; fi
    ( draw_text "$TEXT" "/tmp/bk.png" black transparent )
    if [ ! -e "/tmp/bk.png" ];
    then
	echo "raw text image not found; abort";
	exit -1;
    fi
    if [ ! -e "/tmp/rainbow.png" ];
    then
	echo "create rainbow image"
	convert xc:black xc:red xc:orange xc:yellow xc:green1 xc:cyan xc:blue xc:blueviolet xc:black +append -filter Cubic -resize 600x30! -flop /tmp/rainbow.png;
    fi
    ## convert /tmp/bk.png -colorspace gray /tmp/rainbow.png -clut $OUTPATH;
    WIDTH=`convert /tmp/bk.png -format '%[width]' info:-`;
    HEIGHT=`convert /tmp/bk.png -format '%[height]' info:-`;
    convert -geometry ${WIDTH}x${HEIGHT}! /tmp/rainbow.png /tmp/rainbow_resize.png;
    composite -compose dst_in /tmp/bk.png /tmp/rainbow_resize.png -matte $OUTPATH;
}

function draw_rainbow_text_wall(){
    TEXT=$1;
    OUTPATH="output.png";
    ROW=10;
    COL=10;
    TEXT_BUF="";
    if [ "$2" ]; then OUTPATH=$2; fi
    if [ "$3" ]; then ROW=$3; fi
    if [ "$4" ]; then COL=$4; fi
    ##
    CNT1=0; CNT2=0;
    while [ "$CNT1" -lt "$ROW" ];
    do
	if [ "$CNT1" -gt 0 ]; then TEXT_BUF="${TEXT_BUF}\n"; fi
	TEXT_BUF="${TEXT_BUF}${TEXT}";
	CNT2=0;
	while [ "$CNT2" -lt "$COL" ];
	do
	    CNT2=`expr $CNT2 + 1`;
	    TEXT_BUF="$TEXT_BUF $TEXT";
	done
	CNT1=`expr $CNT1 + 1`;
    done
    echo -e $TEXT_BUF;
    draw_rainbow_text "$TEXT_BUF" $OUTPATH;
}

function overlay_rainbow_text_wall(){
    TEXT=$1;
    ORG_PATH="input.png";
    ORG_PATH_TMP="/tmp/$ORG_PATH";
    OUTPATH="output.png";
    ROW=10;
    COL=10;
    if [ "$2" ]; then ORG_PATH=$2; fi
    if [ "$3" ]; then OUTPATH=$3; fi
    if [ "$4" ]; then ROW=$4; fi
    if [ "$5" ]; then COL=$5; fi
    draw_rainbow_text_wall $TEXT $OUTPATH $ROW $COL;
    ##
    WIDTH=`convert $OUTPATH -format '%[width]' info:-`;
    HEIGHT=`convert $OUTPATH -format '%[height]' info:-`;
    convert $ORG_PATH -resize ${WIDTH}x${HEIGHT} $ORG_PATH_TMP;
    composite -dissolve 10%x50% $OUTPATH $ORG_PATH_TMP $OUTPATH;
}

## source text_image.sh ; draw_rainbow_text_wall "無価値" mukachi.png 30 20
## source text_image.sh ; draw_rainbow_text_wall "金" kane.png 30 60
## source text_image.sh; overlay_rainbow_text_wall "あほ";