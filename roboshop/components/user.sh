#!/bin/bash

COMPONENT=user

source components/common.sh

print "Installing nginx" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
stat $?

print "Adding Roboshop project user" "useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Download user component code" 'curl -s -L -o /tmp/user.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'
curl -s -L -o /tmp/user.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
stat $?

print "Extract user user component code" "rm -rf /home/roboshop/user && mkdir -p /home/roboshop/user && cd /home/roboshop/user && unzip /tmp/user.zip"
rm -rf /home/roboshop/user && mkdir -p /home/roboshop/user && cd /home/roboshop/user && unzip /tmp/user.zip
stat $?

print "Install NodeJS Dependencies" "npm install"
npm install --unsafe-perm
stat $?

chown roboshop:roboshop /home/roboshop -R

print "Update systemD script for user" "sed -i -e 's/MONGO_DNSNAME/mongodb-ss.shaik.cf' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service
/etc/systemd/system/user.service"
sed -i -e 's/MONGO_DNSNAME/mongodb-ss.shaik.cf/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
stat $?

print "Start user service" "systemctl daemon-reload && systemctl restart user && systemctl enable user"
systemctl daemon-reload && systemctl restart user && systemctl enable user
stat $?
