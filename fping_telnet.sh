#!/bin/bash

a=`fping -g 100.100.0.0/24  2>&1 | grep alive | awk '{print $1}'` #диапазон задаём тот что используется

set -x

#Входные данные:

USER="admin"
PASSWD="admin"
LOG="telnet.log"
HOSTS="echo ${a}"

for H in $HOSTS
do
echo START SCRIPT: >> $LOG
date +%x-%R >> $LOG
(
sleep 1;
echo -en "$USER\r";
sleep 1;
echo -en "$PASSWD\r";
sleep 1;
echo -en "sh ipif\r"; #команды которые использует вендор
sleep 1;
echo -en "logo\r";    #это у меня для длинка 
sleep 1;
) | telnet $H >> $LOG
echo =================================== >> $LOG
done
