#!/bin/bash

USER_ID=$(id_u)
if [ "$USER_ID" -ne 0 ]; then
  echo You Should run your script as sudo or root user
  exit
fi

echo -e "\e[31m Installing Nginx \e[0m"
yum install nginx -y
if [ $? -eq 0 ]; then
  echo  -e "\e[31mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 1
fi

echo -e "\e[32m Downloding Nginx \e[0m"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ $? -eq 0 ]; then
  echo  -e "\e[31mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 2
fi
echo -e "\e[33m Cleanup Old Nginx Content and Extract New Downloded Archive \e[0m"

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ]; then
  echo  -e "\e[31mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 2
fi
echo -e "\e[34m Starting Nginx \e[0m"

systemctl restart nginx
systemctl enable nginx

