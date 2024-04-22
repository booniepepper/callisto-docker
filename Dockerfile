FROM alpine

WORKDIR "/opt"

RUN apk add dub dmd gcc git libc-dev libunwind nasm
RUN git clone https://github.com/callisto-lang/compiler.git callisto

WORKDIR "/opt/callisto"

RUN git submodule update --init --remote --recursive
RUN dub build

WORKDIR "/tmp"

ENV PATH="/opt/callisto:${PATH}"
COPY eval /bin

CMD ["cac"]
