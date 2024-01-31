FROM alpine:latest
RUN apk update && apk add helix tree-sitter-grammars gcc
VOLUME /code
RUN adduser -D coder
USER coder
RUN wget -O - https://sh.rustup.rs | ash /dev/stdin -y -c rust-analyzer
ENV PATH="/home/coder/.cargo/bin:${PATH}"
ENV TERM="xterm-256color"
COPY config.toml /home/coder/.config/helix/config.toml
WORKDIR /code
ENTRYPOINT ["hx"]

