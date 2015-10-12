#!/usr/bin/env bash

function parse_jsk_bib_html(){
    OUT=0; IN=1;
    MODE=$OUT;
    ID=1;
    BUF="";
    BIB_HTML="out.html";
    if [ "$1" ]; then BIB_HTML=$1; fi;
    cat $BIB_HTML | grep -e "\[[0-9]\]" -A 5 | while read line;
    do
        if [ "`echo $line | grep -e \"\[$ID\]\"`" ];
        then
        ## echo "[${ID}]";
        ## ID=`expr $ID + 1`;
            MODE=$IN;
        elif [ "`echo $line | grep -e \"</table>\"`" ];
        then
            MODE=$OUT;
            echo "[${ID}]" $BUF;
            BUF="";
            ID=`expr $ID + 1`;
        else
            if [ "$MODE" -eq "$IN" ];
            then
                BUF="${BUF} `echo $line | sed -e \"s/<.\+>//g\"`";
            fi
        fi
    done
}


curl -s -A "Mozilla/5" "http://www.jsk.t.u-tokyo.ac.jp/cgi-bin/bib/bib2htm.cgi?file=13&mode=toukou&lang=en" -o out.html;
parse_jsk_bib_html out.html;