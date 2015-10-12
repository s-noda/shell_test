#!/usr/bin/env bash

function parse_jsk_bib_html(){
    OUT=0; IN=1;
    MODE=$OUT;
    ID=1;
    BUF="";
    BIB_HTML="out.html";
    GREP="";
    if [ "$1" ]; then BIB_HTML=$1; fi;
    if [ "$2" ]; then GREP=$2; fi;
    ##
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
            ## echo "echo \"${BUF}\" | grep -e \"${GREP}\"";
            if [ "`echo \"${BUF}\" | grep -e \"${GREP}\"`" ];
            then
                echo $BUF;
                ID=`expr $ID + 1`;
            fi
            BUF="";
        else
            if [ "$MODE" -eq "$IN" ];
            then
                BUF="${BUF} `echo $line | sed -e \"s/<.\+>//g\"`";
            fi
        fi
    done
}

function file_id_reset(){ echo -n "0" > /tmp/id.dat; }
function file_id_next(){ ID=`cat /tmp/id.dat`; echo -n "`expr $ID + 1`" > /tmp/id.dat; echo $ID; }

NAME="Murooka\|室岡";
echo "parse jsk_bib  in last 5 years...";
file_id_reset;

TYPE="toukou";
echo ">> Journals";
for year in 10 11 12 13 14 15;
do
    curl -s -A "Mozilla/5" "http://www.jsk.t.u-tokyo.ac.jp/cgi-bin/bib/bib2htm.cgi?file=${year}&mode=${TYPE}&lang=en" -o out.html;
    parse_jsk_bib_html out.html | grep -e "$NAME" | while read line;
    do
        echo "[`file_id_next`] $line";
    done
done

TYPE="international";
echo ">> International Conference";
for year in 10 11 12 13 14 15;
do
    curl -s -A "Mozilla/5" "http://www.jsk.t.u-tokyo.ac.jp/cgi-bin/bib/bib2htm.cgi?file=${year}&mode=${TYPE}&lang=en" -o out.html;
    parse_jsk_bib_html out.html | grep -e "$NAME" | while read line;
    do
        echo "[`file_id_next`] $line";
    done
done

TYPE="domestic";
echo ">> Domestic Conference";
for year in 10 11 12 13 14 15;
do
    curl -s -A "Mozilla/5" "http://www.jsk.t.u-tokyo.ac.jp/cgi-bin/bib/bib2htm.cgi?file=${year}&mode=${TYPE}&lang=en" -o out.html;
    parse_jsk_bib_html out.html | grep -e "$NAME" | while read line;
    do
        echo "[`file_id_next`] $line";
    done
done
