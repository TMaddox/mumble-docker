# Dockerized Mumble Server

## Requirements

* Install [Docker](https://docs.docker.com/).
* If on Mac OS X, or any other platform which tends to only have a Docker client, you'll also need a Docker daemon running remotely, [exposing the API](https://docs.docker.com/reference/api/docker_remote_api_v1.19/).
* This can also easily be run on a [Docker Swarm](https://docs.docker.com/swarm/) cluster.


## Setup

There are two example configuration files in this repository, if you don't already have one, that you can copy and modify to your liking. Once you've done that, you can create a data-container to hold your configuration file:


```bash
$ docker run -i --name mumble-conf --entrypoint /bin/bash tmaddox/murmur:1.0 -c 'cat > ./mumble-server.ini' < ./mumble-server.ini
```

Once that's done, you can start the service like so:

```bash
$ docker run -d --restart always --name mumble-server --volumes-from mumble-conf -p $DESIRED_HOST_PORT:64738 tmaddox/murmur:1.0
```

## Configure while running

Because the volume used in this image (`/var/lib/mumble-server`) includes the Mumble database that persists things like your superuser password, channel configurations, access controls, etc., you can run commands against the Mumble binary that will make updates to this database for your running server.

For example, here's how you can set your `SuperUser` password on your running Mumble server.

```bash
$ docker run -i --rm --volumes-from mumble-conf murmur:1.0 -supw secret_to_guard_the_precious
```

## Migrating existing Mumble server

In order to migrate from an existing server, you'll need a copy of the source server's SQLite database file (usually found at `/var/lib/mumble-server/mumble-server.sqlite`). Once you have that, place it and your `mumble-server.ini` in a directory together.

For example, I have a directory `mumble-server-conf` with both a `mumble-servver.ini` and a `mumble-server.sqlite` from an old mumble-server deploy:

```bash
$ tar cv mumble-server-conf/* | docker run -i --name mumble-conf --entrypoint /bin/bash tmaddox/murmur:1.0 -c 'tar x'
```

This created my `mumble-conf` data container, created an archive via `tar cv mumble-server-conf/*`, and then piped it through STDIN to be extracted inside `mumble-conf`'s working directory (`/var/lib/mumble-server`).

Now, I can just start the server like normal, but this time it's using the `mumble-conf` data container and the generic `tmaddox/murmur:1.0` image. :smile:

```bash
$ docker run -d --restart always --name mumble-server --volumes-from mumble-conf -p $DESIRED_HOST_PORT:64738 tmaddox/murmur:1.0
```

Sláinte! :beers:
