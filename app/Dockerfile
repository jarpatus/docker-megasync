# Start from Debian
FROM debian:bookworm-slim

# Copy application files to /app
COPY . /app

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y procps sudo

# Install megacmd
ADD https://mega.nz/linux/repo/Debian_12/amd64/megacmd-Debian_12_amd64.deb /tmp/megacmd.deb
RUN apt install -y /tmp/megacmd.deb
RUN rm /tmp/megacmd.deb

# Run init script
CMD ["sh", "/app/init.sh"]
