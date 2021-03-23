FROM ubuntu:18.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install basic software

RUN apt update
RUN apt install --assume-yes wget 
RUN apt install --assume-yes curl 
RUN apt install --assume-yes git
RUN apt install --assume-yes apt-utils 
RUN apt install --assume-yes gnupg

# Install Java 8

RUN apt install --assume-yes openjdk-8-jre 
RUN apt install --assume-yes openjdk-8-jdk 
RUN apt install --assume-yes openjdk-8-doc 

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Install Scala 2.12.13

RUN wget https://downloads.lightbend.com/scala/2.12.13/scala-2.12.13.deb
RUN dpkg -i ./scala-2.12.13.deb
RUN rm scala-2.12.13.deb

# Install SBT

RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt update
RUN apt install --assume-yes sbt 

# Install Node.js and npm

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash
RUN apt install --assume-yes nodejs

# Expose ports

EXPOSE 3000
EXPOSE 9000

# Add additional information and buffer space

RUN useradd --create-home rafjar1188 --shell /bin/bash

RUN adduser rafjar1188 sudo

# Changing user
USER rafjar1188

# Changing current working directory
WORKDIR /home/rafjar1188/

RUN mkdir /home/rafjar1188/e-biznes

VOLUME ["/home/rafjar1188/e-biznes"]
