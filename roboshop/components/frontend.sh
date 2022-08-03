#!/bin/bash

StatCheck() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[31mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[0m"
    exit 2
  fi
}
Print() {
  echo -e "\n -----------------$1--------------" &>>$LOG_FILE
  echo -e "\e[35m $1 \e[0m"
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo You Should run your script as sudo or root user
  exit 1
fi

LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE

Print "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
StatCheck $?

Print "Downloding Nginx"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "Cleanup Old Nginx Content and Extract New Downloded Archive"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
Statcheck $1
cd /usr/share/nginx/html/

Print "Extracting Archive"
unzip /tmp/frontend.zip &>>$LOG_FILE && mv frontend-main/* &>>$LOG_FILE. && mv static/* . &>>$LOG_FILE
Statcheck $?

Print "Update Roboshop Configuration"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
StatCheck $1

Print "Starting Nginx"
systemctl restart nginx &>>$LOG_FILE && systemctl enable nginx &>>$LOG_FILE
StatCheck $?



