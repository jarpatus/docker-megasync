#!/bin/sh

# SIGTERM handler, gracefully log out and quit megacmd server
_term() {
  echo Got sigterm, logging out and quitting megacmd server...
  tail --pid=`pidof mega-cmd-server` -f /dev/null &
  sudo -u megacmd mega-logout
  sudo -u megacmd mega-quit
  wait
  exit 0
}

# Check enable file
echo Check if enabled...
if [ -n "$ENABLE_FILE" ] && [ ! -f /data/$ENABLE_FILE ]; then
  echo Enable file does not exist!
  exit 2
fi

# Add user for megacmd
if ! grep -q -e "^megacmd:" /etc/passwd; then
  echo Add user for megacmd...
  adduser --shell /sbin/nologin --disabled-password --uid $UID megacmd
fi

# Setup config
echo Setup config...
if [ "$FIX_CONF" = "true" ]; then
  chown -R megacmd:megacmd /config
  chmod 0700 /config
fi
sudo -u megacmd ln -s -f /config /home/megacmd/.megaCmd

# Setup data
echo Setup data...
if [ "$FIX_DATA" = "true" ]; then
  chown -R megacmd:megacmd /data
fi

# Login to mega (will spawn megacmd server)
echo Logging in...
sudo -u megacmd mega-login $USERNAME $PASSWORD
if [ $? -ne 0 -a $? -ne 54 ]; then
  echo Login failed: $?
  exit 1
fi

# Start sync
echo Starting sync...
sudo -u megacmd mega-sync /data /

# Wait for megacmd server to quit uncommanded (sigterm trap will handle gracefull quit)
echo Wait for megacmd server to quit...
trap _term TERM
tail --pid=`pidof mega-cmd-server` -f /dev/null &
wait
exit 1
