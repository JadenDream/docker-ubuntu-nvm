# docker-nvm-base
FROM ubuntu
MAINTAINER John *Seg* Seggerson <seg@segonmedia.com>

# Set home envrioment
ENV HOME /home

# Add apt repositories
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list  && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-security main universe' >> /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates main universe' >> /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://archive.ubuntu.com/ubuntu precise main universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://archive.ubuntu.com/ubuntu precise-security main universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://archive.ubuntu.com/ubuntu precise-updates main universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    mkdir -p $HOME && \
    apt-get update && \
    apt-get install -y python-software-properties python-pip git curl wget sudo socat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Establish baseline with updates.
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -qy build-essential libssl-dev git man curl
RUN apt-get clean

# Install NVM.
RUN curl --location https://raw.github.com/creationix/nvm/master/install.sh | sh && \
    /bin/bash -c "echo \"[[ -s \$HOME/.nvm/nvm.sh ]] && . \$HOME/.nvm/nvm.sh\" >> /etc/profile.d/npm.sh" && \
    echo "[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh" >> $HOME/.bashrc

ENV PATH $HOME/.nvm/bin:$PATH

# Set entrypoint and Bash.
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["bash"]
