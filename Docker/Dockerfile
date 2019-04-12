FROM ubuntu:16.04
MAINTAINER lin777 cusi.evelyn@gmail.com
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get install -y gnupg2
RUN wget -O - http://download.opensuse.org/repositories/devel:/languages:/pharo:/stable/xUbuntu_16.04/Release.key | apt-key add -
RUN echo "deb http://download.opensuse.org/repositories/devel:/languages:/pharo:/stable/xUbuntu_16.04/ ./" > /etc/apt/sources.list.d/pharo.list 
RUN apt update

RUN apt install pharo6-64-ui -y

RUN dpkg --add-architecture i386 
RUN apt-get update 
RUN apt-get install -y libx11-6:i386 libgl1-mesa-glx:i386 libfontconfig1:i386 libssl1.0.0:i386 unzip screen net-tools

WORKDIR /home
RUN mkdir esug
WORKDIR /esug

COPY createPharoImage.sh createPharoImage.sh
COPY startPharoImage.sh startPharoImage.sh

RUN chmod +x createPharoImage.sh
RUN ./createPharoImage.sh

EXPOSE 8000
