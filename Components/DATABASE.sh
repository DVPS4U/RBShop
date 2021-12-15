#!/bin/bash
echo -e "\e[1:31m :::>>MANGODB SETUP>>:: \e[0m "
source Components/CommonScript.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG_FILE}
STAT_CHECK $? "MongoDB Download"

yum install -y mongodb-org  &>>${LOG_FILE}
STAT_CHECK $? "MongoDB Installation"

#Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
sed -i 's/127.0.0.1 /0.0.0.0/' /etc/mongod.conf &>>${LOG_FILE}
STAT_CHECK $? "Update MongoD Service"

systemctl enable mongod &>>${LOG_FILE} && systemctl restart mongod &>>${LOG_FILE}
STAT_CHECK $? "MongoDB Restart"



DOWNLOAD mongodb

cd /tmp/mongodb-main
mongo < catalogue.js &>>${LOG_FILE}
mongo < users.js &>>${LOG_FILE}
STAT_CHECK $? "LOAD SCHEMA"

## Redis Setup

#Install Redis.
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
STAT_CHECK $? "Redis Download"

yum install redis -y &>>${LOG_FILE}
STAT_CHECK $? "Redis Installation"

#Update the BindIP from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf & /etc/redis/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${LOG_FILE} && sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>${LOG_FILE}
STAT_CHECK $? "Redis Update"

#Start Redis Database

systemctl enable redis &>>${LOG_FILE} && systemctl restart redis &>>${LOG_FILE}
STAT_CHECK $? "Redis Restarted"