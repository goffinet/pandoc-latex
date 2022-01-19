FROM pandoc/latex

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

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
    yarn \
    msttcorefonts-installer \
    fontconfig \
    font-noto \
    terminus-font \
    ttf-opensans \
    font-misc-misc \
    font-croscore \
    && update-ms-fonts \
    && fc-cache -f \
    && rm -rf /var/cache/*

RUN npm init && npm install --global mermaid-filter --unsafe-perm=true && npm install

RUN fc-list : family | cut -f1 -d"," | sort | uniq
