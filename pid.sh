#!/usr/bin/env sh

echo $$;

## echo "eval \"echo \$$; while [ \"true\" ]; do sleep 1; done; \"" | /bin/sh;
echo "eval \"echo \$$\"" | /bin/sh;

eval "echo \$$; while [ \"true\" ]; do sleep 1; done; " &

ps --ppid $$ | grep -v -e "\(ps\|grep\)$"