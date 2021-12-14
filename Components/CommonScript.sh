#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -f ${LOG_FILE}

STAT_CHECK() {
  if [ $1 -ne 0 ];then
  echo -e "\e[1;m ${2} - FAILED /e[0m"

exit 1
else
  echo -e "\e[1;m ${2} - FAILED /e[0m"
fi
}