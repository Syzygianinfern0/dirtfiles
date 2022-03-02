FROM ubuntu

ENV TERM xterm-256color

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -yqq install \
        curl \
        git \
        sudo \
        tmux \
        vim \
        wget \
        zsh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install dotfiles
COPY install_dots.sh /tmp

RUN cd /tmp && ./install_dots.sh

# Run a zsh session
CMD [ "/bin/zsh" ]
