FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y curl git silversearcher-ag libssl1.0-dev npm sudo && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/stable && \
    apt-get install -y neovim python-dev python-pip python3-dev python3-pip

RUN useradd -ms /bin/bash rustacean && echo "rustacean ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER rustacean
ENV HOME /home/rustacean
WORKDIR /home/rustacean

RUN git clone https://github.com/luan/vimfiles.git && \
    ./vimfiles/bin/install && \
    vim +PlugInstall +qall
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y
ENV PATH="$HOME/.cargo/bin:${PATH}"
