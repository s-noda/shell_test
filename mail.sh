#!/usr/bin/env sh

## sudo apt-get install mailutils
## tail /var/log/mail.log
## sudo dpkg-reconfigure postfix

SLEEP_TIME=3600;
while [ "true" ];
do
    sleep $SLEEP_TIME;
    if [ "`svn up | wc -l`" == "1" ];
    then
        echo "not updated";
        echo -e "Oops... \n murooka mthesis not updated in last ${SLEEP_TIME} seconds." | mail -s "murooka mthesis not updated in last ${SLEEP_TIME} seconds." --to hoge@mail.com;
    else
        echo "yes updated";
        echo -e "Yahoo!!! \n murooka mthesis updated in last ${SLEEP_TIME} seconds." | mail -s "murooka mthesis updated in last ${SLEEP_TIME} seconds." --to hoge@mail.com;
    fi
done
