
#!/bin/bash
#Включение отладки bash:
set -x


#Учетные данные:
USER="admin"
PASSWD="your pass"

#Файл логов:
LOG="ssh_conn.log"

#Список хостов:
HOSTS="
10.10.10.1
"

#Цикл переборки хостов:
for H in $HOSTS
do

#Вывод даты старта скрипта:
echo START SCRIPT: >> $LOG
date +%x-%R >> $LOG

#Команды для expect:
COMM="

#Включение и вывод отладки expect:
#log_file debug.log
#exp_internal 1

#Время ожидание expect
set timeout 1

#Соедиение ssh:
spawn ssh -T $USER@$H
expect \"*(yes/no)?*\" {send \"yes\r\"}
expect \"Password:\"
send \"$PASSWD\r\"

#Выполняемые команды:
expect \"*>\"
send -- \"/system routerboard print\r\"
expect \"*>\"
send \"exit\r\"

#Завершение выполнения expect:
expect eof
"

#Запуск expect с набором команд:
expect -c "$COMM" >> $LOG
#Вывод разделителя:
echo ========================================================================= >> $LOG

done
