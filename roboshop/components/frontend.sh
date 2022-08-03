#!/bin/bash

source components/common.sh

Print "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
StatCheck $?

Print "Downloding Nginx"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "Cleanup Old Nginx Content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
Statcheck $1

cd /usr/share/nginx/html/

Print "Extracting Archive"
unzip /tmp/frontend.zip &>>$LOG_FILE && mv frontend-main/* . &>>$LOG_FILE && mv static/* . &>>$LOG_FILE
Statcheck $?

Print "Update Roboshop Configuration"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
StatCheck $1

Print "Starting Nginx"
systemctl restart nginx &>>$LOG_FILE && systemctl enable nginx &>>$LOG_FILE
StatCheck $?



