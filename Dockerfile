FROM ubuntu:16.04

ENV LAST_UPDATED_AT 2017-09-19

ARG steam_user=anonymous
ARG steam_password=

RUN apt-get update \
# install dependencies
    && apt-get install -y lib32gcc1 curl lib32stdc++6 \
# delete apt cache to save space
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /csgo

# extract local steamcmd into image
#ADD steamcmd_linux.tar.gz /steamcmd
RUN mkdir -p /steamcmd && cd /steamcmd && \
    curl -sqL "http://media.steampowered.com/client/steamcmd_linux.tar.gz" | tar zxvf -

# install CSGO
RUN cd /steamcmd && ./steamcmd.sh +login $steam_user $steam_password +force_install_dir /csgo +app_update 740 validate +quit

COPY containerfs /

WORKDIR /csgo

CMD ["./start.sh"]
