# mumble-docker

Mumble server Dockerfile and configuration

# How to use
```bash
$ git clone git@github.com:TMaddox/mumble-docker.git
$ cd mumble-docker
$ cp mumble-server.ini.example mumble-server.ini
```
Now modify any values you want in the `mumble-server.ini` configuration file. I highly recommend setting a server password by changing the `serverpassword` attribute. :)
```bash
$ docker build -t murmur .
...
$ docker run --name mumble-server -p <host_port>:64738 murmur
```

Example systemd service definition: https://github.com/TMaddox/rcfiles/blob/master/mumble.service.2

Good luck!
