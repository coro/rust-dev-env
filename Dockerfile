FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y curl neovim

RUN useradd --create-home rustacean
USER rustacean
WORKDIR /home/rustacean

RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y
