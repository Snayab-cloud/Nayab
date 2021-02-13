#!/bin/bash

USER_ID=$(id -u)

#if [ "$USER_ID" = 0 ]; then
#  echo -e "\e[31mYou must be a root user to execute the script\e[0m"
#fi

#print() {
#  echo -e "\e[1m $(date +%c) \e[35m$(hostname)\e[0m  :: $1"
#}

print() {
  echo -e "[\e[1;34mINFO\e[0m]-----------------< $1 >----------------------"
  echo -e "[\e[1;34mINFO\e[0m]\e[1m $2 \e[0m"
  echo -e "[\e[1;34mINFO\e[0m]---------------------------------------------"

}