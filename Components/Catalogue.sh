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
#curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#cd /home/roboshop
#unzip /tmp/catalogue.zip
#mv catalogue-main catalogue
#cd /home/roboshop/catalogue
#npm install
#NOTE: We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
