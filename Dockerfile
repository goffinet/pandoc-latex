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
    yarn \
    ttf-ubuntu-font-family \
    font-noto

RUN /usr/bin/chromium-browser --version

COPY puppeteerConfigFile.json /etc/puppeteerConfigFile.json

RUN npm install --global mermaid-filter --unsafe-perm=true && npm install
