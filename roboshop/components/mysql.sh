#!/bin/bash

COMPONENT=mysql

source components/common.sh

print "Setup MySQL Repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
stat $?

print "Install MySQL" "yum remove mariadb-libs -y && yum install mysql-community-server -y"
yum remove mariadb-libs -y
yum install mysql-community-server -y

print "Start MySQL service" "systemctl enable mysqld && systemctl start mysqld"
systemctl enable mysqld
systemctl start mysqld
stat $?

print "Grab Default MySQL password" "grep temp /var/log/mysqld.log"
DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $?

echo DEFAULT_PASSWORD=$DEFAULT_PASSWORD

print "Reset MySQL password"
mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Default_Roboshop*999';
uninstall plugin validate_password;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
EOF
STAT $?


# mysql_secure_installation


# mysql -u root -p



