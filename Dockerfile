from fpco/stack-build

run curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
run sudo add-apt-repository -y ppa:git-core/ppa
run apt-get -y update && apt-get install -y \
  git \
  httpie \
  libsass-dev \
  nodejs \
  time
run which node

# Install OpenJDK
run apt-get install -y pkg-config libcairo2-dev libjpeg-dev libgif-dev

run echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
run curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
run curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
run sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
run sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl docker-ce parallel

run stack upgrade
run stack setup 8.0.2

# SQL stuff
run apt-get install -y bundler postgresql-client

run apt-get clean

env PATH "$PATH:~/.local/bin"
