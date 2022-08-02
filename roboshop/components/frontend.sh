#!/bin/bash

USER_ID=$(id_u)
if [ "$USER_ID" -ne 0 ]; then
  echo You Should run your script as sudo or root user
  exit
fi

echo -e "\e[31m Installing Nginx \e[0m"
yum install nginx -y

echo -e "\e[32m Downloding Nginx \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

echo -e "\e[33m Cleanup Old Nginx Content and Extract New Downloded Archive \e[0m"

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[34m Starting Nginx \e[0m"

systemctl restart nginx
systemctl enable nginx

