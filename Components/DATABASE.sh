#!/bin/bash
source Components/CommonScript.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>> ${LOG_FILE}
STAT_CHECK $? "MongoDB Download"

yum install -y mongodb-org  &>> ${LOG_FILE}
STAT_CHECK $? "MongoDB Installation"

#Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
sed -i 's/127.0.0.1 /0.0.0.0/' /etc/mongod.conf &>> ${LOG_FILE}
STAT_CHECK $? "Update MongoD Service"

systemctl enable mongod &>> ${LOG_FILE} && systemctl restart mongod &>> ${LOG_FILE}
STAT_CHECK $? "MongoDB Restart"



Download mongodb

cd mongodb-main
mongo < catalogue.js &>> ${LOG_FILE} && mongo < users.js &>> ${LOG_FILE}
STAT_CHECK $? "LOAD SCHEMA"

