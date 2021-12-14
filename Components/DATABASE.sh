#!/bin/bash
source Components/$CommonScript.sh
yum install mongodb-org -y  &>> ${LOG_FILE}
STATUS_CHECK $? "MongoDB Installation"

systemctl enable mongod &>> ${LOG_FILE} && systemctl restart mongod &>> ${LOG_FILE}
STATUS_CHECK $? "MongoDB Restart"

#Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file

#Config file: /etc/mongod.conf

#then restart the service

# systemctl restart mongod
Every Database needs the schema to be loaded for the application to work.
Download the schema and load it.

# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

