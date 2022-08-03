#!/bin/bash

StatCheck() {
  if [ $1 -eq 0 ]; then
    echo  -e "\e[31mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[0m"
    exit 2
  fi
}
Print() {
  echo -e "\e[35m $1 \e[0m"
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo You Should run your script as sudo or root user
  exit 1
fi

Print "Installing Nginx"
yum install nginx -y
StatCheck $1

Print "Downloding Nginx"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
StatCheck $1

Print "Cleanup Old Nginx Content and Extract New Downloded Archive"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
StatCheck $1

Print "Starting Nginx"
systemctl restart nginx
StatCheck $1
systemctl enable nginx

