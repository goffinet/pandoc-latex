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

# Installs latest Chromium package.
RUN apk add --no-cache \
    msttcorefonts-installer fontconfig \
    font-noto \
    font-noto-adlam \
    font-noto-adlamunjoined \
    font-noto-arabic \
    font-noto-armenian \
    font-noto-avestan \
    font-noto-bamum \
    font-noto-bengali \
    font-noto-buhid \
    font-noto-carian \
    font-noto-chakma \
    font-noto-cherokee \
    font-noto-cypriot \
    font-noto-deseret \
    font-noto-devanagari \
    font-noto-ethiopic \
    font-noto-extra \
    font-noto-georgian \
    font-noto-glagolitic \
    font-noto-gothic \
    font-noto-gujarati \
    font-noto-gurmukhi \
    font-noto-hebrew \
    font-noto-kannada \
    font-noto-kayahli \
    font-noto-khmer \
    font-noto-lao \
    font-noto-lisu \
    font-noto-malayalam \
    font-noto-mandaic \
    font-noto-myanmar \
    font-noto-nko \
    font-noto-olchiki \
    font-noto-oldturkic \
    font-noto-oriya \
    font-noto-osage \
    font-noto-osmanya \
    font-noto-shavian \
    font-noto-sinhala \
    font-noto-tamil \
    font-noto-telugu \
    font-noto-thaana \
    font-noto-thai \
    font-noto-tibetan \
    font-noto-tifinagh \
    font-noto-vai \
    terminus-font \
    ttf-opensans \
    font-bakoma \
    font-misc-misc \
    font-croscore \
    ttf-ubuntu-font-family

RUN fc-cache -f && rm -rf /var/cache/*

RUN npm install --global mermaid-filter --unsafe-perm=true && npm install

RUN fc-list : family | cut -f1 -d"," | sort
