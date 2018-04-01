#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
MY_NTP=$SCRIPTPATH/ntp.conf
NTP=/etc/ntp.conf

# Install NTP
apt install -y ntp

# Replace default config
cp $MY_NTP $NTP

# Restart NTP server
systemctl restart ntp

# Add cronjob for ntp_verify.sh every minute
crontab -l > mycron
echo "* * * * * $SCRIPTPATH/ntp_verify.sh" >> mycron
crontab mycron
rm mycron

exit 0
