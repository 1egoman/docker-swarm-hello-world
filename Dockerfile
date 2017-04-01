FROM ubuntu:16.04
EXPOSE 8000
ARG ref

RUN apt-get update && apt-get install -y git curl vim

ENV NODE_VERSION v6.10.1
ENV NVM_DIR /usr/local/nvm

# Create a user to run the app
RUN useradd -m -s /bin/bash app

# Install node
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Setup a place to put the app
RUN mkdir /app
RUN chmod 755 /app
RUN chown -R app:app /app

USER app

# add node to the path
ENV PATH $PATH:/usr/local/nvm/versions/node/$NODE_VERSION/bin
ENV NODE_ENV production
ENV PORT 8000

# pull down source and set it up
RUN git clone https://github.com/1egoman/docker-swarm-hello-world.git /app
RUN cd /app && git checkout ${ref:-master}
RUN cd /app && npm install

# Run the app
CMD cd /app && npm start
