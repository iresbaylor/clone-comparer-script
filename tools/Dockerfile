FROM ubuntu:latest

# Install curl & make
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y make && \
    apt-get install -y gcc

WORKDIR /txl

# Install Txl
RUN curl https://www.txl.ca/download/25043-txl10.7.linux64.tar.gz > txl.tar.gz
RUN tar -xzf txl.tar.gz
RUN cd txl10.7.linux64 && ./InstallTxl

# Install NiCad
RUN curl https://www.txl.ca/download/31017-NiCad-5.2.tar.gz > nicad.tar.gz
RUN tar -xzf nicad.tar.gz
RUN cd NiCad-5.2 && make