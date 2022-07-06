FROM openjdk:11

USER root
RUN cd /usr/local && \
        wget -q https://github.com/yahoo/CMAK/releases/download/3.0.0.6/cmak-3.0.0.6.zip && \
        unzip cmak-3.0.0.6.zip && \
        mv cmak-3.0.0.6  cmak && \
        rm -f cmak-3.0.0.6.zip

COPY application.conf   /usr/local/cmak/conf/application.conf

EXPOSE 9000

CMD ["/usr/local/cmak/bin/cmak"]