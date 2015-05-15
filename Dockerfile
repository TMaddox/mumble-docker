FROM ubuntu
MAINTAINER Thomas Maddox

## Installation

RUN apt-get update
RUN apt-get install -y mumble-server
ADD ./mumble-server.ini /etc/mumble-server.ini

## Installation END

CMD ["/usr/sbin/murmurd", "-ini", "/etc/mumble-server.ini", "-fg", "-v"]
