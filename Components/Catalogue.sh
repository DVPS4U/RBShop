#!/bin/bash

source Components/CommonScript.sh
Nodejs Catalogue
#yum install nodejs make gcc-c++ -y &>>$"{LOG_FILE}"
#STAT_CHECK $? "Nodejs Installation"
#
#id roboshop &>>$"{LOG_FILE}"
#
#if [ $? -ne 0 ]; then
#  useradd roboshop &>>$"{LOG_FILE}"
#  STAT_CHECK $? "Add Application user"
#fi
#
##So let's switch to the roboshop user and run the following commands.
#
#DOWNLOAD catalogue
#
#rm -rf /home/roboshop/catalogue && mkdir -p /home/roboshop/catalogue && cp -r /tmp/catalogue-main/* /home/roboshop/catalogue &>>$"{LOG_FILE}"
#STAT_CHECK $? "Copy catalogue Content"
#
#
#cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$"{LOG_FILE}"
#STAT_CHECK $? "Install Nodejs"
#
#chown roboshop:roboshop -R /home/roboshop
#
#sed -i -e 's/MONGO_DNSNAME/mongod.x4m.internal/' /home/roboshop/catalogue/systemd.service &>>$"{LOG_FILE}" && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$"{LOG_FILE}"
#STAT_CHECK $? "Update systemd files"
##NOTE: We need to update the IP address of MONGODB Server in systemd.service file
##Now, lets set up the service with systemctl.
#
#systemctl daemon-reload &>>$"{LOG_FILE}" && systemctl start catalogue &>>$"{LOG_FILE}" && systemctl enable catalogue &>>$"{LOG_FILE}"
#STAT_CHECK $? "Start catalogue Service"