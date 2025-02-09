# Start from Alpine Linux
FROM alpine:3.21

# Add packages
RUN apk add --no-cache coreutils megacmd uuidgen

# Add user
RUN addgroup -g $GID megacmd
RUN adduser -s /sbin/nologin -G megacmd -D -u $UID megacmd

# Generate machine-id
RUN uuidgen > /etc/machine-id

# Create config files
COPY ./app /app
RUN ln -s -f /config /home/megacmd/.megaCmd

# Drop root
USER megacmd

# Run init script
CMD ["sh", "/app/init.sh"]
