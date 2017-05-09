FROM fpco/stack-build

RUN apt-get update && apt-get install -y \
  httpie
