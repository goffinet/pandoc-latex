FROM pandoc/latex

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

# Create /data dir where files can be read/written.
ENV \
    DATA_DIRECTORY=/data \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true


RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm \
    yarn

RUN apk add --no-cache msttcorefonts-installer fontconfig

RUN update-ms-fonts

RUN apk add --no-cache \
    msttcorefonts-installer fontconfig \
    font-noto \
    terminus-font \
    ttf-opensans \
    font-bakoma \
    font-misc-misc \
    font-croscore \
    ttf-ubuntu-font-family

RUN fc-cache -f && rm -rf /var/cache/*

RUN npm install --global mermaid-filter --unsafe-perm=true && npm install

RUN fc-list : family | cut -f1 -d"," | sort
