#!/bin/bash
if [ $# == 0 ]
then
    echo "usage: <pids>..."
    exit
fi

count=$#

echo "pid count is $count"

for i in $(seq 1 $count)
do
    echo "pid ${!i}"
done

while :
do
    r=`expr $RANDOM + 10000`
    r=`expr $r / 1000`
    r=`expr $r % 30`
    echo "sleep $r sec"
    sleep $r
    r=`expr $RANDOM % $count`
    r=`expr $r + 1`
    echo "pause pid ${!r}"
    pid=$r
    kill -s SIGSTOP ${!pid}
    r=`expr $RANDOM + 3000`
    r=`expr $r / 1000`
    r=`expr $r % 10`
    echo "continue after $r sec"
    sleep $r
    kill -s SIGCONT ${!pid}
done