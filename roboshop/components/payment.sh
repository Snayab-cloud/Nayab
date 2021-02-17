#!/bin/bash

COMPONENT=payment

source components/common.sh

print "Install Python3" "yum install python36 gcc python3-devel -y"
yum install python36 gcc python3-devel -y
stat $?

print "Create Roboshop user" "id roboshop || useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Download payment code" 'curl -L -s -o /tmp/payment.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/cd32a975-ee45-4b3b-a08e-8e97c3ca7733/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'
curl -L -s -o /tmp/payment.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/cd32a975-ee45-4b3b-a08e-8e97c3ca7733/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
stat $?

print "Extracting payment code" "mkdir -p /home/roboshop/payment && cd /home/roboshop/payment && unzip /tmp/payment.zip"
mkdir -p /home/roboshop/payment && cd /home/roboshop/payment && unzip -o /tmp/payment.zip
stat $?

print "Install python dependencies" "cd /home/roboshop/payment && pip3 install -r requirements.txt"
cd /home/roboshop/payment && pip3 install -r requirements.txt
stat $?

USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)
sed -i -e "/^uid/ c uid=${USER_ID}" -e "/^gid/ c gid=${GROUP_ID}" /home/roboshop/payment/payment.ini
stat $?

chown roboshop:roboshop /home/roboshop -Roboshop

print "Update systemD script for payment" 'sed -i -e "s/CARTHOST/cart-ss.shaik.cf/" -e "s/USERHOST/user-ss.shaik.cf/" -e "s/AMQPHOST/rabbitmq-ss.shaik.cf/" /home/roboshop/payment/systemd.service'
sed -i -e "s/CARTHOST/cart-ss.shaik.cf/" -e "s/USERHOST/user-ss.shaik.cf/" -e "s/AMQPHOST/rabbitmq-ss.shaik.cf/" /home/roboshop/payment/systemd.service
statv $?

print "Start payment service" "mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service && systemctl daemon-reload && systemctl enable payment && systemctl start payment"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service && systemctl daemon-reload && systemctl enable payment && systemctl start payment
stat $?

