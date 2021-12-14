#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -f ${LOG_FILE}

STAT_CHECK() {
  if [ $1 -ne 0 ];then
  echo -e "\e[1m ${2} -\e[32m FAILED \e[m"

exit 1
else
  echo -e "\e[1m ${2} - \e[32m Success \e[m"
fi
}

set-hostname -skip-apply ${Components}

DOWNLOAD(){
curl -s -L -o /tmp/${1} "https://github.com/roboshop-devops-project/${1}/archive/main.zip" &>>${LOG_FILE}
STAT_CHECK $? "${1} Downloaded"

cd /tmp
unzip -o /tmp/${1}.zip &>> ${LOG_FILE}
STAT_CHECK $? "${1} Extracted"

}