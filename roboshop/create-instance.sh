#!/bin/bash

component=$1

if [ -z "${component}" ]; then
  echo "Need a Input of component name"
  exit 1
fi

aws ec2 run-instances --launch-template LaunchTemplateId=lt-0835ecf0be1ed2f76 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]"