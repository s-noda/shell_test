#!/usr/bin/env sh

LAMBDA="echo \$1 \$2 \$3";

function funcall(){
    (
        echo "function _tmp_funcall(){ eval \"$1\"; }";
        eval "function _tmp_funcall(){ eval \"$1\"; }";
        CMD="_tmp_funcall";
        CNT=2;
        while [ $CNT -le $# ];
        do
            ## echo $CNT;
            CMD="$CMD \$${CNT}";
            CNT=`expr $CNT + 1`;
        done
        echo $CMD;
        eval $CMD;
    )
}

function arg_expand(){
    eval "echo $@";
}

function get_partial_func(){
    FUNC=$1;
    CNT=2;
    while [ $CNT -le $# ];
    do
        BUF="sed s/\\\$`expr $CNT - 1`/\$$CNT/g";
        echo $BUF;
        BUF=`arg_expand $BUF`;
        echo $BUF;
        BUF="echo \"$FUNC\" | $BUF";
        echo $BUF;
        FUNC=`eval $BUF`;
        CNT=`expr $CNT + 1`;
        echo $FUNC;
    done
    echo $FUNC;
}

## funcall "$LAMBDA" 10 11 12
## eval "function hoge(){ echo 10; }"
## HOGE="hoge"; FUGA="fuga"; echo "echo \$HOGE \$2 \$3" | sed s/\$HOGE/$FUGA/g
## HOGE="hoge"; FUGA="fuga"; BUF="echo \"echo \$HOGE \$2 \$3" | sed s/\$HOGE/$FUGA/g\""; echo $BUF; eval $BUF;
## HOGE="hoge"; PIYO="HOGE"; FUGA=`eval "echo \"\$$PIYO\""`;
