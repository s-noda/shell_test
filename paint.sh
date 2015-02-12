#!/usr/bin/env sh

C000000="\e[40m";
CFF0000="\e[41m";
C00FF00="\e[42m";
CFFFF00="\e[43m";
C0000FF="\e[44m";
CFF00FF="\e[45m";
C00FFFF="\e[46m";
CFFFFFF="\e[47m";
CLEAR="\e[m";

function test_paint_colors(){
    echo -e "${C000000} ${CFF0000} ${C00FF00} ${C0000FF} ${CFFFF00} ${CFF00FF} ${C00FFFF} ${CFFFFFF} ${CLEAR}";
}

function convert_image_small(){
    convert -geometry 100x100 -depth 1 $1 /tmp/`basename $1`.bmp;
}
