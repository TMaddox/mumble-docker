# Dockerized Mumble Server

## Requirements

* Install [Docker](https://docs.docker.com/).
* If on Mac OS X, or any other platform which tends to only have a Docker client, you'll also need a Docker daemon running remotely, [exposing the API](https://docs.docker.com/reference/api/docker_remote_api_v1.19/).
* This can also easily be run on a [Docker Swarm](https://docs.docker.com/swarm/) cluster.


## Setup

There are two example configuration files in this repository, if you don't already have one, that you can copy and modify to your liking. Once you've done that, you can create a data-container to hold your configuration file:


```bash
$ docker run -i --name mumble-conf --entrypoint /bin/bash tmaddox/murmur:1.0 -c 'cat > ./mumble-server.ini' < mumble-server-prod.ini/mumble-server.ini
```

Once that's done, you can start the service like so:

```bash
$ docker run --restart always --name mumble-server --volumes-from mumble-conf -p $DESIRED_HOST_PORT:64738 tmaddox/murmur:1.0
```

Sláinte! :beers:
