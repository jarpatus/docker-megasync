# docker-megaio-sync
Dockerized mega.io sync client using official megacmd.

# Installation
Use Docker Compose, example docker-compose.yml:
```
services:
  megasync:
    build:
      context: app
    container_name: megasync
    environment:
      UID: 126473
      GID: 126473
      USERNAME: xxx
      PASSWORD: xxx
      FIX_CONF: "true"
      FIX_DATA: "true"
      ENABLE_FILE: .megasync-enable
    volumes:
      - ./config/:/config
      - /etc/machine-id:/etc/machine-id:ro
      - /mnt/backup/Mega/:/data
    restart: unless-stopped
```

## Environment variables
* ```UID``` - UID for megacmd user.
* ```GID``` - GID for megacmd group.
* ```USERNAME``` - Your mega.io username.
* ```PASSWORD``` - Your mega.io password.
* ```FIX_CONF``` - Fix owner of /config to match UID:GID on container start.
* ```FIX_DATA``` - Fix owner of /data to match UID:GID on container start.
* ```ENABLE_FILE``` - If set, a file of this name must exist under /data in order to sync to start.

## Mounts
You should use volumes or bind mounts for all following folders:
* ```/config``` - Session files for megacmd  
* ```/data``` - Folder to be syncced to mega.io
* ```/etc/machine-id```- Unique machine ID  

# Considerations
* For UID and GID you can choose values from existing user on docker host or then something non-existing above 65536. You could use dockerized samba with similar UID and GID to totally decouple users from host users, but everything depends on your needs.
* Protect docker-compose.yaml as it contains your mega.io credentials. Also on container start an login process will be launched which contains username and password, which can be read by other users on you docker host so this is insecure (to be fixed somehow)!
* As we are running megacmd as a new user, /config and /data must be owned by that user. Either manually chown files recursively or set FIX_CONF and FIX_DATA which will do recirsive chowns on container start (this happens using root so be carefully to set mounts right!).
* Use ENABLE_FILE for safety, so that if your /data is mounted incorrectly or not mounted at all, megacmd won't mess up your cloud.
* Cloud is never backup solution. Always have backups. Always.
