FROM alpine:latest

RUN apk --no-cache add gcc helix rustup tree-sitter-rust

VOLUME /code

RUN adduser -D coder
USER coder
WORKDIR /home/coder

RUN wget -O - https://sh.rustup.rs | ash /dev/stdin -y -c rust-analyzer

ENV PATH="/home/coder/.cargo/bin:${PATH}"
ENV TERM="xterm-256color"

COPY config.toml /home/coder/.config/helix/config.toml

WORKDIR /code

ENTRYPOINT ["hx"]
