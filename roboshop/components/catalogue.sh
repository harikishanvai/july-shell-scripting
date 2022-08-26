#!/bin/bash

source components/common.sh

Print "Configure Yum repos"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>${LOG_FILE}
StatCheck $?

Print "Install NodeJS"
yum install nodejs gcc-c++ -y &>>${LOG_FILE}
StatCheck $?


id ${APP_USER} &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  Print "Add Apllication User"
  useradd ${APP_USER} &>>${LOG_FILE}
  StatCheck $?
fi

Print "Download app content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
StatCheck $?

Print "cleanup old content"
rm -rf /home/roboshop/catalogue &>>${LOG_FILE}
StatCheck $?

Print "Extract app content"
cd /home/roboshop &>>${LOG_FILE} && unzip -o /tmp/catalogue.zip &>>${LOG_FILE} && mv catalogue-main catalogue &>>${LOG_FILE}
StatCheck $?

Print "Install app dependencies"
cd /home/roboshop/catalogue &>>${LOG_FILE} && npm install &>>${LOG_FILE}
StatCheck $?

Print "Fix app user permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

