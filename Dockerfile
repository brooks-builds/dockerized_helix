FROM alpine:latest

VOLUME [ "/code" ]

RUN apk update && apk add helix tree-sitter-grammars gcc nodejs npm
RUN adduser -D helixuser
RUN npm i -g typescript-language-server typescript

USER helixuser

RUN wget -O - https://sh.rustup.rs | ash /dev/stdin -y -c rust-analyzer

ENV PATH=/home/helixuser/.cargo/bin:${PATH}
ENV COLORTERM=truecolor
COPY --chown=helixuser:helixuser config.toml /home/helixuser/.config/helix/config.toml
COPY --chown=helixuser:helixuser languages.toml /home/helixuser/.config/helix/languages.toml

WORKDIR /code
ENTRYPOINT [ "hx" ]
