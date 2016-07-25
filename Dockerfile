FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get -y upgrade && apt-get -y -f install software-properties-common
RUN add-apt-repository -y ppa:mozillateam/firefox-next


# TOOLS
RUN apt-get install -y -q build-essential screen sudo curl wget vim git python


# VNC
RUN apt-get install -y -q x11vnc xvfb


# Updating nodejs to V6
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install -y -q nodejs


# Chrome + Firefox
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -y
RUN apt-get install -y -q default-jre
RUN apt-get install -y -q firefox
RUN apt-get install -y -q google-chrome-stable

# Create sudo account
RUN useradd -m devdock && echo "devdock:devdock" | chpasswd && adduser devdock sudo
RUN chown -R devdock /home/devdock
RUN chgrp -R devdock /home/devdock

# Selenium + Phantomjs
RUN npm config set unsafe-perm true
RUN npm install -g selenium-standalone@latest phantomjs-prebuilt@2.1.4 && selenium-standalone install

RUN mkdir -p /home/devdock/workspace
RUN mkdir -p /home/devdock/.git-aware-prompt/

COPY ./.files/git-aware-prompt/ /home/devdock/.git-aware-prompt/
COPY ./.files/.bash_profile /home/devdock/
COPY ./.files/.bashrc /home/devdock/
COPY ./.files/.screenrc /home/devdock/.screenrc

USER root
EXPOSE 3000 3001 4444 5999

#ENTRYPOINT ["sh", "/home/devdock/_startSelenium.sh", ">", "/dev/null", "2>&1", "&"]
#ENTRYPOINT ["sh", "/home/devdock/_startSelenium.sh"]


