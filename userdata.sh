#!/bin/bash
yum update -y
yum install -y git httpd
systemctl enable httpd
systemctl start httpd
amazon-linux-extras install docker -y
systemctl enable docker
systemctl start docker
usermod -a -G docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
cd /tmp
git clone https://github.com/esthermurambikar/Docker-compose.git
cd Docker-compose
docker-compose up -d
