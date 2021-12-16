#!/bin/bash



source Components/CommonScript.sh
#echo -e "\e[31m :::>>MANGODB SETUP>>:: \e[31m "
#
#curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG_FILE}
#STAT_CHECK $? "MongoDB Download"
#
#yum install -y mongodb-org  &>>${LOG_FILE}
#STAT_CHECK $? "MongoDB Installation"
#
##Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
#sed -i 's/127.0.0.1 /0.0.0.0/' /etc/mongod.conf &>>${LOG_FILE}
#STAT_CHECK $? "Update MongoD Service"
#
#systemctl enable mongod &>>${LOG_FILE} && systemctl restart mongod &>>${LOG_FILE}
#STAT_CHECK $? "MongoDB Restart"
#
#
#
#DOWNLOAD mongodb
#
#cd /tmp/mongodb-main
#mongo < catalogue.js &>>${LOG_FILE}
#mongo < users.js &>>${LOG_FILE}
#STAT_CHECK $? "LOAD SCHEMA"
#
### Redis Setup
#echo -e "\e[31m :::>>Redis SETUP>>::: \e[31m "
##Install Redis.
#curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
#STAT_CHECK $? "Redis Download"
#
#yum install redis -y &>>${LOG_FILE}
#STAT_CHECK $? "Redis Installation"
#
##Update the BindIP from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf & /etc/redis/redis.conf
#sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${LOG_FILE} && sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>${LOG_FILE}
#STAT_CHECK $? "Redis Update"
#
##Start Redis Database
#systemctl enable redis &>>${LOG_FILE} && systemctl restart redis &>>${LOG_FILE}
#STAT_CHECK $? "Redis Restarted"
#
#
#echo -e "\e[31m :::>>RabbitMQ SETUP>>:: \e[31m "
#
#curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG_FILE}
#STAT_CHECK $? "Download RabbitMQ"
##Erlang is a dependency which is needed for RabbitMQ.
#yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>${LOG_FILE}
#STAT_CHECK $? "RabbitMQ & Erlang Installed"
##Start RabbitMQ
#systemctl enable rabbitmq-server &>>${LOG_FILE} && systemctl restart rabbitmq-server &>>${LOG_FILE}
#STAT_CHECK $? "RabbitMQ Retarted"
##RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence we need to create one user for the application.
##Create application user
#rabbitmqctl list_users | grep roboshop &>>${LOG_FILE}
#if [ $? -ne 0 ]; then
# rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
# STAT_CHECK $? "RabbitMQ User Created"
#
#fi
#
#rabbitmqctl set_user_tags roboshop administrator &>>${LOG_FILE}
#rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG_FILE}
#STAT_CHECK $? "RabbitMQ User Permission"

#Setup MySQL Repo
echo -e "\e[31m :::>>MySQL SETUP>>::: \e[31m "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${LOG_FILE}
STAT_CHECK $? "MySQL Download"
#Install MySQL
yum install mysql-community-server -y &>>${LOG_FILE}
STAT_CHECK $? "MySQL Installation"
#Start MySQL.
systemctl enable mysqld &>>${LOG_FILE} && systemctl restart mysqld &>>${LOG_FILE}
STAT_CHECK $? "MySQL Restarted"

#Now a default root password will be generated and given in the log file.
DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')

echo 'SHOW DATABASE;' | mysql -uroot -pRoboShop@1 &>>{LOG_FILE}

if [ $? -ne 0 ]; then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" >/tmp/pass.sp1
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" </tmp/pass.sp1  &>>{LOG_FILE}
  STAT_CHECK $? "Setup new Root Password"
fi
echo 'show plugins;' | mysql -uroot -pRoboShop@1 2>>${LOG_FILE} | grep validate_password &>>${LOG_FILE}
if [ $? -eq 0 ]; then
echo 'uninstall plugin validate_password;' |  mysql -uroot -pRoboShop@1 &>>${LOG_FILE}
STAT_CHECK $? "Uninstall Password Plugin"
fi

DOWNLOAD mysql
STAT_CHECK $? "Download MySql"
cd /tmp/mysql-main
mysql -u root -pRoboShop@1 <shipping.sql &>>${LOG_FILE}
STAT_CHECK $? "Load Schema"