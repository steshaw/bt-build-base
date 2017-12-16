from fpco/stack-build:lts-8.17

# Make debconf noninteractive (to silent warnings).
run echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

run curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
run sudo add-apt-repository -y ppa:git-core/ppa
run apt-get -qy update && apt-get -qy install \
  git \
  httpie \
  libsass-dev \
  nodejs \
  sudo \
  time \
  vim
run which node

# Install OpenJDK
run apt-get -qy install pkg-config libcairo2-dev libjpeg-dev libgif-dev

run echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
run curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
run curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
run sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
run sudo apt-get -qy update && sudo apt-get -qy install google-cloud-sdk kubectl docker-ce parallel

run stack --silent upgrade
run stack --silent setup 8.0.2

# SQL stuff
run apt-get -qy install bundler postgresql-client

run apt-get -qy clean

env PATH "$PATH:~/.local/bin"

# Allow the 'stack' user to sudo with password.
run useradd stack
run adduser stack sudo
run echo 'stack ALL=(root) NOPASSWD:ALL' >> /etc/sudoers
