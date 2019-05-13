FROM ubuntu:18.04
MAINTAINER lin777 cusi.evelyn@gmail.com
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install unzip screen net-tools wget libx11-6:i386  libgl1-mesa-glx:i386 libfontconfig1:i386 libssl1.0.0$
RUN apt update

WORKDIR /home
RUN mkdir esug
WORKDIR /esug

COPY createPharoImage.sh createPharoImage.sh
COPY startPharoImage.sh startPharoImage.sh

RUN chmod +x startPharoImage.sh
RUN chmod +x createPharoImage.sh
RUN ./createPharoImage.sh

EXPOSE 8000
