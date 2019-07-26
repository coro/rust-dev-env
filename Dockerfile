FROM ubuntu:latest

ENV HOME /home/rustacean
WORKDIR /home/rustacean
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y curl git silversearcher-ag libssl1.0-dev npm sudo

# Install neovim
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/stable && \
    apt-get install -y neovim python-dev python-pip python3-dev python3-pip

# Install luanvimfiles
RUN git clone https://github.com/luan/vimfiles.git && ./vimfiles/bin/install

RUN vim +PlugInstall +qall
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y
ENV PATH="$HOME/.cargo/bin:${PATH}"
