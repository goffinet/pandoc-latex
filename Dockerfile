# pandoc-latex image

FROM registry.hub.docker.com/pandoc/ubuntu-latex

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | \
    debconf-set-selections && \
    apt update && apt -y install \
      fonts-roboto \
      ttf-mscorefonts-installer && \
    fc-cache -f -v
