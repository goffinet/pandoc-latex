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
    yarn \
    ttf-ubuntu-font-family \
    font-noto

RUN /usr/bin/chromium-browser --version

# Puppeteer v0.11.0 works with Chromium 63.
RUN yarn add puppeteer@1.8.0 mermaid.cli@0.5.1

COPY puppeteerConfigFile.json /etc/puppeteerConfigFile.json

# Symlink to PATH.
RUN ln -sf /node_modules/mermaid.cli/index.bundle.js /usr/local/bin/mmdc

# Create data directory.
RUN mkdir -p ${DATA_DIRECTORY}
