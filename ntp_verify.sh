#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
MY_NTP=$SCRIPTPATH/ntp.conf
NTP=/etc/ntp.conf

# Start ntp if not running
if [[ "`systemctl is-active ntp`" != "active"  ]]; then
  echo "NOTICE: ntp is not running"
  systemctl restart ntp
fi

# Detect diff
diff -q $MY_NTP $NTP > /dev/null 2>&1
rc=$?

# Print changes and restart ntp if diff detected
if [[ $rc != 0 ]]; then
  echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:"
  diff -u $MY_NTP $NTP
  cp $MY_NTP $NTP
  systemctl restart ntp
fi

