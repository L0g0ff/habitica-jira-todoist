#!/bin/bash
apt-get update

export TZ="Europe/Amsterdam"
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

echo "Installing prerequisites"
apt install -y \
    lsb-release \
    wget \
    apt-transport-https \
    software-properties-common \
    git \
    nginx

echo "Installing Powershell"
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -sr)/packages-microsoft-prod.deb"
dpkg -i packages-microsoft-prod.deb
apt-get update
add-apt-repository universe
apt-get install -y powershell

echo "Installing Powershell Modules"
pwsh -Command "Install-Module -Name JiraPS, ConfluencePS, Az.Accounts, Az.Advisor -Force"
