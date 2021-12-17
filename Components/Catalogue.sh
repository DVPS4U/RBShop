#!/bin/bash

source Components/CommonScript.sh
yum install nodejs make gcc-c++ -y &>>$"{LOG_FILE}"
STAT_CHECK $? "Nodejs Installation"

id roboshop &>>$"{LOG_FILE}"

if [ $? -ne 0 ]; then
  useradd roboshop &>>$"{LOG_FILE}"
  STAT_CHECK $? "Add Application user"
fi

#So let's switch to the roboshop user and run the following commands.

DOWNLOAD catalogue

rm -rf /home/roboshop/catalogue && mkdir -p /home/roboshop/catalogue && cp -r /tmp/catalogue-main/* /home/roboshop/catalogue &>>$"{LOG_FILE}"
STAT_CHECK $? "Copy catalogue Content"


cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$"{LOG_FILE}"
STAT_CHECK $? "Install Nodejs"
#NOTE: We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
