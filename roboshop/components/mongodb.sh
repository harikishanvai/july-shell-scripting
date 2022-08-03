#!/bin/bash

source components/common.sh

Print "Setup YUM Repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
StatCheck $?

Print "Install MongoDB"
yum install -y mongodb-org &>>$LOG_FILE
StatCheck $?

Print "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
StatCheck $?
Print "Start MongoDB"
systemctl enable mongod &>>$LOG_FILE && systemctl start mongod &>>$LOG_FILE


Download the schema and load it.

```
# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

```

Symbol `<` will take the input from a file and give that input to the command.