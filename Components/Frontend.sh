#!/bin/bash

yum install nginx -y

if [ $? -ne 0 ]; then
  exit 1
fi

systemctl enable nginx

systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

if [ $? -ne 0 ]; then
  exit 1
fi

cd /usr/share/nginx/html

#rm -rf *

#unzip /tmp/frontend.zip

#mv frontend-main/* .

#mv static/* .

#rm -rf frontend-master static README.md

#mv localhost.conf /etc/nginx/default.d/roboshop.conf