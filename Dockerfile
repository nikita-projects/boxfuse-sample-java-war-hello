FROM ubuntu:18.04
RUN apt update && \
    apt install -y curl default-jdk maven docker.io
