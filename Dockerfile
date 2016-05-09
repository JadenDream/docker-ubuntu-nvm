# docker-nvm-base
FROM ubuntu

# Establish baseline with updates.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential libssl-dev git man curl

# Establish root and ENV variables.
USER root
ENV HOME /root
ENV NODE_VER v6.1

# Install NVM.
RUN git clone https://github.com/creationix/nvm.git $HOME/.nvm
RUN echo '\n#Loading NVM for Node.js, then using $NODE_ENV to set version.' >> $HOME/.profile
RUN echo '. ~/.nvm/nvm.sh' >> $HOME/.profile
RUN echo 'echo "Installing node @${NODE_VER} ..."' >> $HOME/.profile
RUN echo 'nvm install ${NODE_VER}' >> $HOME/.profile
RUN echo 'nvm alias default ${NODE_VER}' >> $HOME/.profile
RUN echo 'echo "Installed and set node to @${NODE_VER} ."' >> $HOME/.profile

# Set entrypoint and Bash.
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["bash"]
