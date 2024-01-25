#!/bin/sh

# Check enable file
echo Check if enabled...
if [ -n "$ENABLE_FILE" ] && [ ! -f /data/$ENABLE_FILE ]; then
  echo Enable file does not exist!
  exit 2
fi

# Add user for megacmd
if ! grep -q -e "^megacmd:" /etc/passwd; then
  echo Add user for megacmd...
  addgroup -g $GID megacmd
  adduser -s /sbin/nologin -D -u $UID -G megacmd megacmd
fi

# Setup config
echo Setup config...
if [ "$FIX_CONF" = "true" ]; then
  chown -R megacmd:megacmd /config
  chmod 0700 /config
fi
ln -s -f /config /home/megacmd/.megaCmd

# Setup data
echo Setup data...
if [ "$FIX_DATA" = "true" ]; then
  chown -R megacmd:megacmd /data
fi

# Run main script as megacmd user
exec su megacmd -s /bin/sh -c /app/main.sh
