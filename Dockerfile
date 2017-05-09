FROM fpco/stack-build

RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN apt-get update && apt-get install -y \
  nodejs \
  libsass-dev \
  httpie
RUN which node

# Install GHCJS
RUN git clone https://github.com/ghcjs/ghcjs.git
RUN cd ghcjs && stack setup && stack install
ENV PATH /root/.local/bin:$PATH
RUN cd ghcjs && stack exec -- ghcjs-boot --dev --no-haddock

# Install OpenJDK
RUN apt-get install -y openjdk-9-jdk-headless
RUN npm install -g crass
RUN apt-get install -y pkg-config libcairo2-dev libjpeg-dev libgif-dev

RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl docker-ce parallel

RUN stack setup 8.0.2

# SQL stuff
RUN apt-get install -y bundler postgresql-client

RUN apt-get clean
RUN echo "export PATH=\$PATH:$HOME/.local/bin" >> /root/.bashrc
