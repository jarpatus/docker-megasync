# docker-megaio-sync
Dockerized mega.io sync client using official megacmd.

# Installation
Use Docker Compose, example docker-compose.yml: https://raw.githubusercontent.com/jarpatus/docker-megaio-sync/main/app/docker-compose.yaml.example

## Environment variables
* ```UID``` - UID for megacmd user.
* ```GID``` - GID for megacmd group.
* ```USERNAME``` - Your mega.io username.
* ```PASSWORD``` - Your mega.io password.
* ```FIX_CONF``` - Fix owner of /config to match UID:GID.
* ```FIX_DATA``` - Fix owner of /data to match UID:GID.
* ```ENABLE_FILE``` - If set, a file of this name must exist under /data in order to sync to start. 

## Mounts
You should use volumes or bind mounts for all following folders:
* ```/config``` - Session files for megacmd  
* ```/data``` - Folder to be syncced to mega.io
* ```/etc/machine-id```- Unique machine ID  
