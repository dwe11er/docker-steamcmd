FROM ubuntu:xenial
# sadly we cannot use Alpine here because of the 32bit libstdc++ dependency

MAINTAINER SFoxDev <admin@sfoxdev.com>

ENV LC_ALL=C.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	STEAMID="376030" \
	INSTALLDIR="/home/steam/game/"

RUN apt update \
	&& apt install -y lib32gcc1 curl mc \
	&& apt clean \
	&& useradd -m steam \
	&& cd /home/steam\
	mkdir Steam

WORKDIR /home/steam/Steam
ADD install.sh /home/steam/Steam
RUN chown -R steam:steam /home/steam/Steam \
	&& curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
	&& chmod u+x install.sh

USER steam

CMD ["/home/steam/Steam/install.sh"]
