ARG POLIPO_VERSION="1.1.1"

FROM alpine:latest AS builder

LABEL maintainer="AUTUMN"

ARG POLIPO_VERSION

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

WORKDIR /home

RUN wget https://github.com/jech/polipo/archive/polipo-${POLIPO_VERSION}.tar.gz 

RUN tar -xvf polipo-${POLIPO_VERSION}.tar.gz

RUN apk add make alpine-sdk && \
    cd polipo-polipo-${POLIPO_VERSION} && \
    make

FROM alpine:latest

ARG POLIPO_VERSION

RUN mkdir -p /polipo/cache

COPY --from=builder /home/polipo-polipo-${POLIPO_VERSION}/polipo /usr/bin/polipo

EXPOSE 1081

CMD ["/usr/bin/polipo", "-c", "/polipo/config"]

