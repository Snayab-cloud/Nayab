#!/bin/bash

COMPONENT=frontend

source components/common.sh

print "Installing nginx" "yum install nginx -y"
yum install nginx -y
stat $?


print "Downloading frontend content" "curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/e869c1fe-489d-4f58-b676-fb75fe4e9e12/_apis/git/repositories/18fbb315-ed99-4a65-9b79-e7eec2f3e1b1/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/e869c1fe-489d-4f58-b676-fb75fe4e9e12/_apis/git/repositories/18fbb315-ed99-4a65-9b79-e7eec2f3e1b1/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
stat $?

print "Download old docs" "cd /usr/share/nginx/html ; rm -rf *"
cd /usr/share/nginx/html
rm -rf *
stat $?

print "Extract Roboshop frontend Docs" "unzip /tmp/frontend.zip"
unzip /tmp/frontend.zip && mv static/* . && rm -rf static README.md
stat $?

print "Setup Nginx config for Roboshp" "mv localhost.conf /etc/nginx/default.d/roboshop.conf"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

print "starting nginx service" "systemctl start nginx"
systemctl enable nginx
systemctl start nginx
stat $?
