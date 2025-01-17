# Start from Alpine Linux
FROM alpine:3.21

# Add packages
RUN apk add --no-cache coreutils megacmd uuidgen

# Copy application files to /app
COPY ./app /app

# Run init script
CMD ["sh", "/app/init.sh"]
