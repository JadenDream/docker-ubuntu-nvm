# docker-nvm-base
FROM ubuntu:precise
MAINTAINER John *Seg* Seggerson <seg@segonmedia.com>

# Add apt repositories
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise-security main universe' >> /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise-updates main universe' >> /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu precise main universe' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu precise-security main universe' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu precise-updates main universe' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse' >> /etc/apt/sources.list
RUN mkdir -p $HOME
RUN apt-get update
RUN apt-get -f install
RUN apt-get build-dep -qy build-essential libssl-dev git curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Set home envrioment
#add user node and use it to install node/npm and run the app
RUN useradd --home /home/node -m -U -s /bin/bash node

RUN echo 'Defaults !requiretty' >> /etc/sudoers; \
    echo 'node ALL= NOPASSWD: /usr/sbin/dpkg-reconfigure -f noninteractive tzdata, /usr/bin/tee /etc/timezone, /bin/chown -R node\:node /myapp' >> /etc/sudoers;


USER node

# Install NVM.
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
ENV NODE_VERSION 6.1
ENV NVM_DIR /home/node/.nvm
ENV PATH $HOME/.nvm/bin:$PATH
RUN . ~/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && npm install -g bower forever --user "node"

# Set entrypoint and Bash.
#CMD ["bash"]
