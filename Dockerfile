FROM alpine:latest

VOLUME [ "/code" ]

RUN apk update && apk add helix tree-sitter-grammars gcc
RUN adduser -D helixuser

USER helixuser

RUN wget -O - https://sh.rustup.rs | ash /dev/stdin -y -c rust-analyzer

ENV PATH=/home/helixuser/.cargo/bin:${PATH}
COPY --chown=helixuser:helixuser config.toml /home/helixuser/.config/helix/config.toml

WORKDIR /code
ENTRYPOINT [ "hx" ]
