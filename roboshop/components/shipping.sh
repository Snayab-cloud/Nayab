#!/bin/bash

COMPONENT=user

source components/common.sh

print "Installing Maven" "yum install maven -y"
yum install maven -y
stat $?

print "Adding Roboshop Project User" "useradd roboshop"
useradd roboshop
stat $?

print "Download shipping code" 'curl -s -L -o /tmp/shipping.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/9c06b317-6353-43f6-81e2-aa4f5f258b2d/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'
curl -s -L -o /tmp/shipping.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/9c06b317-6353-43f6-81e2-aa4f5f258b2d/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
stat $?


print "Extract Shipping code" "mkdir /home/roboshop/shipping && cd /home/roboshop/shipping && unzip /tmp/shipping.zip"
mkdir -p /home/roboshop/shipping && cd /home/roboshop/shipping && unzip /tmp/shipping.zip
stat $?

print "Maven compile code" "mvn clean package && mv target/shipping-1.0.jar shipping.jar"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
stat $?


print "Update SystemD script for shipping" "sed -i -e 's/CART_ENDPOINT/cart-ss.shaik.cf/' -e 's/DBHOST/mysql-ss.shaik.cf/' /home/roboshop/shipping/systemd.service"
sed -i -e 's/CARTENDPOINT/cart-ss.shaik.cf/' -e 's/DBHOST/mysql-ss.shaik.cf/' /home/roboshop/shipping/systemd.service
stat $?

print "Start shipping service" "mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service && systemctl daemon-reload && systemctl start shipping && systemctl enable shipping"
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service && systemctl daemon-reload && systemctl start shipping && systemctl enable shipping
stat $?
