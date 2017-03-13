#!/bin/bash

# Start supervisord
echo "Starting supervisord..."
/usr/bin/supervisord -c /etc/supervisord.conf

# sleep waiting services to start
sleep 3

if [ -e /srv/account.builder ]; then
   echo "Ring files already exist in /srv, copying them to /etc/swift..."
   cp /srv/*.builder /etc/swift/
   cp /srv/*.gz /etc/swift/
fi
if [ ! -e /etc/swift/account.builder ]; then

    echo "No existing ring files, creating them..."
    /usr/local/bin/initStorage.sh
    /usr/local/bin/remakerings

    # Back these up for later use
    echo "Copying ring files to /srv to save them if it's a docker volume..."
    cd /etc/swift
    cp *.gz /srv
    cp *.builder /srv
fi

echo "Starting swift...."
swift-init main start
tail -n 0 -f /var/log/anaconda/syslog

