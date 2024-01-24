# Start from Alpine Linux
FROM alpine:3.18

# Add packages (coreutils needed for tail --pid)
RUN apk add --no-cache coreutils sudo megacmd

# Copy application files to /app
COPY ./app /app

# Run init script
CMD ["sh", "/app/init.sh"]
