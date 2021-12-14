#!/bin/bash
source Components/CommonScript.sh

yum install nginx -y &>> $"{LOG_FILE}"
STAT_CHECK $? "Nginx Installation"

rm -rf  /usr/share/nginx/html/*
STAT_CHECK $? "Remove Old HTML files"

cd /tmp/frontend-main/static && cp -r * /usr/share/nginx/html
STAT_CHECK $? "Copying Frontend Content"

cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update NGINX File"

systemctl enable nginx &>> ${LOG_FILE} && systemctl restart nginx &>> ${LOG_FILE}
STAT_CHECK $? "Restart Nginx"