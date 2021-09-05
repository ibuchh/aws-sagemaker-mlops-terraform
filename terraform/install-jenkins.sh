#!/bin/bash
sudo yum -y update

echo "Install Java JDK 11"

sudo amazon-linux-extras install -y java-openjdk11

echo "Install Docker engine"

sudo yum update -y
sudo yum install docker -y
sudo chkconfig docker on

echo "Install Git"

sudo yum update -y
sudo yum install git -y

echo "Install Jenkins"

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

echo "enabling the EPEL repo on Amazon Linux"
sudo amazon-linux-extras install epel -y
sudo yum update -y

sudo yum install -y jenkins
sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on

echo "Start Docker and Jenkins"

sudo service docker start
sudo service jenkins start


