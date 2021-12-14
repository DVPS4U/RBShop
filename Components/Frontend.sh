#!/bin/bash
source Components/CommonScript.sh

yum install nginx -y &>> ${LOG_FILE}
STAT_CHECK $? "Nginx Installation"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
STAT_CHECK $? "Download Frontend"

rm -rf  /usr/share/nginx/html/*
STAT_CHECK $? "Remove Old HTML files"

cd /tmp && unzip -o /tmp/frontend.zip &>> ${LOG_FILE}
STAT_CHECK $? "Extracting Frontend Content"

cd /tmp/frontend-main/static && cp -r * /usr/share/nginx/html
STAT_CHECK $? "Copying Frontend Content"

cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update NGINX File"

system_ctl enable nginx &>>$ {LOG_FILE} && system_ctl restart nginx &>>$ {LOG_FILE}
STAT_CHECK $? "Restart Nginx"