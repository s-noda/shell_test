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
    cat $BIB_HTML | grep -e "\[[0-9]\+\]" -A 5 | while read line;
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
                BUF="${BUF} `echo $line | sed -e \"s/<[^>]\+>//g\"`";
            fi
        fi
    done
}

function file_id_reset(){ echo -n "0" > /tmp/id.dat; }
function file_id_next(){ ID=`cat /tmp/id.dat`; echo -n "`expr $ID + 1`" > /tmp/id.dat; echo $ID; }

function gen_bib(){
    NAME="Murooka\|MUROOKA\|室岡"; if [ "$1" ]; then NAME=$1; fi;
    YEAR_ALL="10 11 12 13 14 15"; if [ "$2" ]; then YEAR_ALL=$2; fi;
    ECHO_COLOR="31"; if [ "$3" ]; then ECHO_COLOR=$3; fi;
    TYPE="toukou";  if [ "$4" ]; then TYPE=$4; fi;

    for year in ${YEAR_ALL};
    do
	curl -s -A "Mozilla/5" "http://www.jsk.t.u-tokyo.ac.jp/cgi-bin/bib/bib2htm.cgi?file=${year}&mode=${TYPE}&lang=en" -o out.html;
	nkf -Ew --overwrite out.html
	parse_jsk_bib_html out.html | grep -e "$NAME" | while read line;
	do
            echo -e "\e[${ECHO_COLOR}m [`file_id_next`] $line \e[m";
	done
    done
}

function gen_bib_all(){
    NAME="Murooka\|MUROOKA\|室岡"; if [ "$1" ]; then NAME=$1; fi ##"Noda\|NODA\|野田";
    YEAR_ALL="10 11 12 13 14 15"; if [ "$2" ]; then YEAR_ALL=$2; fi;
    echo "parse jsk_bib for $NAME in last 5 years...";
    file_id_reset;

    echo -e "\e[41m >> Journals \e[m";
    gen_bib "$NAME" "$YEAR_ALL" "31" "toukou";

    echo -e "\e[42m >> International Conference \e[m";
    gen_bib "$NAME" "$YEAR_ALL" "32" "international";

    echo -e "\e[43m >> Domestic Conference \e[m";
    gen_bib "$NAME" "$YEAR_ALL" "33" "domestic";
}
