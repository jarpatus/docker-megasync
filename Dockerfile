# Start from Alpine Linux
FROM alpine:3.18

# Add packages
RUN apk add --no-cache coreutils megacmd

# Copy application files to /app
COPY ./app /app

# Run init script
CMD ["sh", "/app/init.sh"]
