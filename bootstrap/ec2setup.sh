#!/bin/bash

echo "::: user_data bootstrap init"
sudo apt update && 
sudo apt --yes install docker.io docker-compose &&
sudo usermod -a -G docker ubuntu
