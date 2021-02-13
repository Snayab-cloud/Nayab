#!/bin/bash

USER_ID=$(id -u)

#if [ "$USER_ID" = 0 ]; then
#  echo -e "\e[31mYou must be a root user to execute the script\e[0m"
#fi

print() {
  echo -e "\e[1m $(data +%c) \e[35m$(hostname)\e[0m \e[1;36m$(COMPONENT)\e[0m :: $1"
}