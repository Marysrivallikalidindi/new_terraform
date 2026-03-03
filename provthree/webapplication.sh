#!/bin/bash
touch file1

sudo apt update

mkdir user1

sudo apt install nginx -y

sudo systemctl start nginx

sudo systemctl enable nginx
