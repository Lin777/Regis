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
RUN apt-get install -y libx11-6:i386 
RUN apt-get install -y libgl1-mesa-glx:i386 
RUN apt-get install -y libfontconfig1:i386 
RUN apt-get install -y libssl1.0.0:i386 

RUN apt-get install unzip
RUN apt-get install screen -y

WORKDIR /home
RUN mkdir esug
WORKDIR /esug

COPY esugDocker.sh esug.sh

RUN chmod +x esug.sh
RUN ./esug.sh

EXPOSE 8000