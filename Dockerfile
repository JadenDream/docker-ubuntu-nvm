# docker-nvm-base
FROM ubuntu
MAINTAINER John *Seg* Seggerson <seg@segonmedia.com>

# Establish baseline with updates.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential libssl-dev git man curl

# Install NVM.
RUN curl --location https://raw.github.com/creationix/nvm/master/install.sh | sh && \
    /bin/bash -c "echo \"[[ -s \$HOME/.nvm/nvm.sh ]] && . \$HOME/.nvm/nvm.sh\" >> /etc/profile.d/npm.sh" && \
    echo "[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh" >> $HOME/.bashrc

ENV PATH $HOME/.nvm/bin:$PATH

# Set entrypoint and Bash.
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["bash"]
