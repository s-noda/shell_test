#!/usr/bin/env sh

function sigma(){
    if [ "$1" == "0" ];
    then
        echo 0;
    else
        eval "expr $1 + `sigma \`expr $1 - 1\``";
    fi;
}

function fib(){
    if [ "$1" -lt "0" ];
    then
        if [ "`expr $1 % 2`" == "0" ];
        then
            echo `expr -1 \* \`fib \\\`expr -1 \* $1\\\`\``;
        else
            echo `expr 1 \* \`fib \\\`expr -1 \* $1\\\`\``;
        fi;
    elif [ "$1" == "0" ];
    then
        echo 0;
    elif [ "$1" == "1" ];
    then
        echo 1;
    else
        echo `expr \`fib \\\`expr $1 - 1\\\`\` + \`fib \\\`expr $1 - 2\\\`\``;
    fi;
}

function fib_test(){
    ID=0;
    MAX=10;
    while [ $ID -lt $MAX ];
    do
        echo -n "[$ID] ";
        echo -e " `fib $ID`\t(`fib \`expr -1 \* $ID\``)";
        ID=`expr $ID + 1`;
    done;
}

# eval "expr 1 + `expr 1 + 1`";
# eval "expr 1 + `eval \"expr 1 + 1\"`";
# eval "expr 1 + `eval "expr 1 + \`eval \"expr 1 + 1\"\`"`";

# expr 1 + `expr 1 + \`expr 1 + 1\``
# expr 1 + `expr 1 + \`expr 1 + \\\`expr 1 + 1\\\`\``