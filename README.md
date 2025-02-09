# docker-megasync
Dockerized mega.io sync client using official megacmd.

# Build
To build image, clone repository to src/, copy example docker-compose.yaml to cwd and build:

```
git clone https://github.com/jarpatus/docker-megaio-sync.git src
cp src/examples/docker-compose.yaml .
docker-compose build
```

## Environment variables
* ```UID``` - UID for megacmd user.
* ```GID``` - GID for megacmd group.
* ```USERNAME``` - Your mega.io username.
* ```PASSWORD``` - Your mega.io password.
* ```ENABLE_FILE``` - If set, a file of this name must exist under /data in order to sync to start.

## Mounts
You should use volumes or bind mounts for all following folders:
* ```/config``` - Session files for megacmd  
* ```/data``` - Folder to be syncced to mega.io

# Considerations
* For UID and GID you can choose values from existing user on docker host or then something non-existing above 65536. You could use dockerized samba with similar UID and GID to totally decouple users from host users, but everything depends on your needs.
* Protect docker-compose.yaml as it contains your mega.io credentials. Also on container start an login process will be launched which contains username and password, which can be read by other users on you docker host so this is insecure (to be fixed somehow)!
* As we are running megacmd as a new user, /config and /data must be owned by that user. Either manually chown files recursively or set FIX_CONF and FIX_DATA which will do recirsive chowns on container start (this happens using root so be carefully to set mounts right!).
* Use ENABLE_FILE for safety, so that if your /data is mounted incorrectly or not mounted at all, megacmd won't mess up your cloud.
* Cloud is never backup solution. Always have backups. Always.
