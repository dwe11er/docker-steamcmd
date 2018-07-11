FROM ubuntu:bionic
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

RUN dpkg --add-architecture i386 \
	&& apt update \
	&& apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 \
	&& apt clean

WORKDIR /home/steam/Steam
ADD install.sh /home/steam/Steam

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
	&& chmod u+x install.sh \
	&& chmod u+x /home/steam/Steam/steamcmd.sh \
	&& chown -R steam:steam /home/steam/Steam

USER steam

CMD ["/home/steam/Steam/install.sh"]
