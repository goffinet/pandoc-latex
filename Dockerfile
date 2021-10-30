# pandoc-latex image

FROM ubuntu:20.04

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y -q \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-xetex \
  python3-pip \
  libx11-xcb-dev \
  libxcomposite-dev \
  libxcursor-dev \
  libxdamage-dev \
  libxtst-dev \
  libxss-dev \
  libxrandr-dev \
  libasound-dev \
  libatk1.0-dev \
  libatk-bridge2.0-dev \
  libpango1.0-dev \
  libgtk-3-dev \
  fonts-roboto \
  fonts-noto \
  wget

RUN export DEBIAN_FRONTEND=noninteractive \
  && wget -O- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y -q yarn nodejs npm \
  && npm cache clean -f \
  && npm install -g n \
  && n stable

RUN pip3 install panflute

RUN ln -sf /node_modules/.bin/mmdc /usr/bin/mmdc

RUN wget https://github.com/jgm/pandoc/releases/download/2.15/pandoc-2.15-linux-amd64.tar.gz \
  && tar zxf pandoc-2.15-linux-amd64.tar.gz \
  && mv pandoc-2.15/bin/* /usr/bin/

RUN yarn add mermaid mermaid.cli

COPY pandoc_filter.py /pandoc_filter.py

RUN chmod +x /pandoc_filter.py

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y -q autoremove \
  && rm -rf /var/lib/apt/lists/
