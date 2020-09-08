
#!/bin/bash
set -x

USER="admin"

LOG="ssh_conn_by_cert.log"

HOSTS="
10.10.10.1
"

for H in $HOSTS
do

echo START SCRIPT: >> $LOG
date +%x-%R >> $LOG


COMM="

set timeout 1

spawn ssh -T $USER@$H
expect \"*(yes/no)?*\" {send \"yes\r\"}

expect \"*>\"
send -- \"/system routerboard print\r\"
expect \"*>\"
send \"exit\r\"

expect eof
"

expect -c "$COMM" >> $LOG
echo ========================================================================= >> $LOG

done
