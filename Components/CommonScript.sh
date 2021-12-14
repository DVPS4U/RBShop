#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -f ${LOG_FILE}

STAT_CHECK() {
  if [ $1 -ne 0 ];then
  echo -e "\e[32m ${2} - FAILED \e[m"

exit 1
else
  echo -e "\e[32m ${2} - FAILED \e[m"
fi
}

set-hostname -skip-apply ${Components}