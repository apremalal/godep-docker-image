# https://hub.docker.com/_/golang
FROM golang:1.11.4-alpine3.8

MAINTAINER Anuruddha <anuruddhapremalal@gmail.com>

RUN apk update && \
    apk upgrade && \
    apk add git

RUN go get golang.org/x/tools/cmd/goimports
RUN go get github.com/beego/bee
RUN go get honnef.co/go/tools/cmd/staticcheck

# dependencies for cgo support
RUN apk add --no-cache gcc
RUN apk add --no-cache g++
RUN apk add --no-cache file
RUN apk add --update --no-cache \
        ca-certificates \
        git mercurial subversion bzr \
        openssh \ 
 && update-ca-certificates \
    \
 # Install build dependencies
 && apk add --no-cache --virtual .build-deps \
        curl make 

# install godep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

ENV PATH=$PATH:$GOPATH/bin
WORKDIR $GOPATH
