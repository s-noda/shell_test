#!/usr/bin/env bash

for p in p1.txt p2.txt; do
    cat $p | while read p; do echo -n "$p "; done > $p.line;
    sed -i "s/[ \t]\+/ /g" $p.line;
done

imax=10;
i=0;
dl=();
_df=();
while [ "$i" -lt "$imax" ]; do
    dl=(${dl[@]} $i)
    i=$(expr $i + 1);
done
for d in $(cat p1.txt.line); do
    i=1;
    while [ "$i" -lt "$imax" ]; do
	dl[$(expr $i - 1)]=${dl[$i]};
	i=$(expr $i + 1);
    done
    dl[$(expr $i - 1)]=$d;
    ## echo ${dl[@]}; read line;
    df="${dl[@]}";
    df=$(grep "$df" p2.txt.line 2> /dev/null);
    __df="${_df[@]}";
    if [ "$df" ]; then
	if [ "${__df}" ]; then
	    _df=(${_df[@]} ${dl[$(expr ${#dl[@]} - 1)]});
	    ## echo ${_df[@]};
	else
	    _df=(${dl[@]});
	fi
    else
	if [ "${__df}" ]; then
	    echo "${_df[@]}";
	fi
	_df=();
    fi
done
