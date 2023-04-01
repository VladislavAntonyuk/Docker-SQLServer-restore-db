FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

ENV ACCEPT_EULA Y
ENV SA_PASSWORD Password_123

RUN apt-get update \
    && \
    apt-get install curl unzip libssl1.0 libssl1.1 -y  \
    && \
    mkdir -p /opt/sqlpackage \
    && \
    curl -L https://go.microsoft.com/fwlink/?linkid=2165213 --output /opt/sqlpackage/sqlpackage.zip \
    && \
    cd /opt/sqlpackage \
    && \
    unzip sqlpackage.zip \
    && \
    rm sqlpackage.zip

COPY ./wait-for.sh   /wait-for.sh
COPY ./entrypoint.sh /entrypoint.sh
COPY ./import.sh     /import.sh

RUN chmod +x /wait-for.sh \
    && \
    chmod +x /entrypoint.sh \
    && \
    chmod +x /import.sh \
    && \
    chmod +x /opt/sqlpackage/sqlpackage

USER mssql

ENTRYPOINT /entrypoint.sh