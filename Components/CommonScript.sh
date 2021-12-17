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
curl -s -L -o /tmp/${1}.zip "https://github.com/roboshop-devops-project/${1}/archive/main.zip" &>>${LOG_FILE}
STAT_CHECK $? "${1} Downloaded"


cd /tmp
unzip -o /tmp/${1}.zip &>>${LOG_FILE}
STAT_CHECK $? "${1} Extracted"

}
NODEJS() {

  yum install nodejs make gcc-c++ -y &>>$"{LOG_FILE}"
  STAT_CHECK $? "Nodejs Installation"

  id roboshop &>>$"{LOG_FILE}"

  if [ $? -ne 0 ]; then
    useradd roboshop &>>$"{LOG_FILE}"
    STAT_CHECK $? "Add Application user"
  fi


  DOWNLOAD ${1}

  rm -rf /home/roboshop/${1} && mkdir -p /home/roboshop/${1} && cp -r /tmp/${1}-main/* /home/roboshop/${1} &>>$"{LOG_FILE}"
  STAT_CHECK $? "Copy ${1} Content"


  cd /home/roboshop/${1} && npm install --unsafe-perm &>>$"{LOG_FILE}"
  STAT_CHECK $? "Install Nodejs"

  chown roboshop:roboshop -R /home/roboshop

  sed -i -e 's/MONGO_DNSNAME/mongod.x4m.internal/' /home/roboshop/${1}/systemd.service &>>$"{LOG_FILE}" && mv /home/roboshop/${1}/systemd.service /etc/systemd/system/catalogue.service &>>$"{LOG_FILE}"
  STAT_CHECK $? "Update systemd files"
  #NOTE: We need to update the IP address of MONGODB Server in systemd.service file
  #Now, lets set up the service with systemctl.

  systemctl daemon-reload &>>$"{LOG_FILE}" && systemctl start ${1} &>>$"{LOG_FILE}" && systemctl enable ${1} &>>$"{LOG_FILE}"
  STAT_CHECK $? "Start ${1} Service"
}