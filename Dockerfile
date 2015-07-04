# Mumble VoIP Server
#
# VERSION:      1.0

FROM ubuntu:14.04
MAINTAINER Thomas Maddox <thomas.e.maddox@gmail.com>

RUN apt-get update
RUN apt-get install -y mumble-server
RUN useradd --create-home -d /mumble-conf --system --shell /sbin/nologin \
    --comment "Account to run murmurd." --user-group mumble

WORKDIR /mumble-conf
VOLUME /mumble-conf

USER mumble
ENTRYPOINT ["/usr/sbin/murmurd", "-ini", "/mumble-conf/mumble-server.ini"]
CMD ["-fg", "-v"]
