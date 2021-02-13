#!/bin/bash

USER_ID=$(id -u)

if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[31mYou must be a root user to execute the script\e[0m"
fi