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

## funcall "$LAMBDA" 10 11 12
## eval "function hoge(){ echo 10; }"
