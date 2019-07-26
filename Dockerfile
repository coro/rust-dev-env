FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y curl git silversearcher-ag

# Install neovim
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/stable && \
    apt-get install -y neovim python-dev python-pip python3-dev python3-pip

# Install luanvimfiles
RUN apt-get install -y libssl1.0-dev npm sudo && \
    git clone https://github.com/luan/vimfiles.git && ./vimfiles/bin/install

RUN useradd --create-home rustacean
USER rustacean
WORKDIR /home/rustacean

RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y
ENV PATH="$HOME/.cargo/bin:${PATH}"
