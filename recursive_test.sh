#!/usr/bin/env sh

function sigma(){
    if [ "$1" == "0" ];
    then
        echo 0;
    else
        eval "expr $1 + `sigma \`expr $1 - 1\``";
    fi;
}

# eval "expr 1 + `expr 1 + 1`";
# eval "expr 1 + `eval \"expr 1 + 1\"`";
# eval "expr 1 + `eval "expr 1 + \`eval \"expr 1 + 1\"\`"`";

# expr 1 + `expr 1 + \`expr 1 + 1\``
# expr 1 + `expr 1 + \`expr 1 + \\\`expr 1 + 1\\\`\``