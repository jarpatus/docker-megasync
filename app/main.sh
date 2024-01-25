#!/bin/sh

# SIGTERM handler, gracefully log out and quit megacmd server
on_term() {
  echo Got sigterm, logging out and quitting megacmd server...
  tail --pid=`pidof mega-cmd-server` -f /dev/null &
  mega-logout
  mega-quit
  wait
  exit 0
}

# Login to mega (will spawn megacmd server)
echo Logging in...
mega-login $USERNAME $PASSWORD
if [ $? -ne 0 -a $? -ne 54 ]; then
  echo Login failed: $?
  exit 1
fi

# Start sync
echo Starting sync...
mega-sync /data /

# Wait for megacmd server to quit uncommanded (sigterm trap will handle gracefull quit)
echo Wait for megacmd server to quit...
trap on_term TERM
tail --pid=`pidof mega-cmd-server` -f /dev/null &
wait
exit 1
