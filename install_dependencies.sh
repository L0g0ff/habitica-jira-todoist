#!/bin/bash
# Check if powershell exists
FILE=/bin/pwsh
	if [ -f "$FILE" ]; then
		echo "$FILE exists. Do NOTHING..."
	else 
		# Install and configure everything
		apt-get update

		export TZ="Europe/Amsterdam"
		ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

		echo "Installing prerequisites"
		apt install -y \
			lsb-release \
			wget \
			apt-transport-https \
			software-properties-common \
			cron
			
		echo "Installing Powershell"
		wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -sr)/packages-microsoft-prod.deb"
		dpkg -i packages-microsoft-prod.deb
		apt-get update
		add-apt-repository universe
		apt-get install -y powershell

		echo "Installing Powershell Modules"

		pwsh -Command "Install-Module -Name Habitica, JiraPS -Force"

		crontab -l | { cat; echo "0 18 * * * /opt/microsoft/powershell/7/pwsh -File /habitica-jira/jira.ps1"; } | crontab -
		crontab -l | { cat; echo "0 22 * * * /opt/microsoft/powershell/7/pwsh -File /habitica-jira/todoist.ps1"; } | crontab -
	fi

# Keep alive docker
/etc/init.d/cron start
/bin/pwsh

