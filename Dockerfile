FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl wget gnupg less lsof net-tools git apt-utils unzip -y


# WORKDIR
RUN mkdir /works
WORKDIR /works

# DART
RUN apt-get install apt-transport-https
RUN sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get install dart -y
ENV PATH="${PATH}:/usr/lib/dart/bin/"
ENV PATH="${PATH}:/root/.pub-cache/bin"

RUN flutter pub global activate webdev
RUN flutter pub global activate stagehand

#
# CODE-SERVER
RUN wget https://github.com/cdr/code-server/releases/download/1.939-vsc1.33.1/code-server1.939-vsc1.33.1-linux-x64.tar.gz
RUN tar xzf code-server1.939-vsc1.33.1-linux-x64.tar.gz -C ./ --strip-components 1


# FLUTTER
RUN apt-get install xz-utils vim -y 
RUN wget https://storage.googleapis.com/flutter_infra/releases/dev/linux/flutter_linux_v1.12.1-dev.tar.xz
RUN mkdir /works/development
WORKDIR /works/development
RUN tar xf ../flutter_linux_v1.12.1-dev.tar.xz
ENV PATH="${PATH}:/works/development/flutter/bin"
RUN flutter precache




#
# FLUTTER CODE
WORKDIR /works/development/flutter/examples/hello_world/
RUN flutter packages upgrade
RUN flutter pub get
RUN flutter --version
RUN flutter config --enable-web
