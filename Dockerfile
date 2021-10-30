# pandoc-latex image

FROM pandoc/latex:2.11.2

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

ARG UID=1000
ARG GID=1000

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
    ttf-ubuntu-font-family

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    PATH="/data/node_modules/.bin:${PATH}"

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser -g $GID && adduser -S -G pptruser -u $UID pptruser \
    && mkdir -p /home/pptruser \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /data \
    && chmod o+w /opt/texlive/texdir/texmf-var

# Puppeteer v5.2.1 works with Chromium 85.
RUN yarn add eslint puppeteer@5.2.1 mermaid-filter

# Install Tex Gyre Termes font
RUN tlmgr update --self && tlmgr install tex-gyre tex-gyre-math selnolig

# Install Noto Color Emoji
RUN mkdir -p /usr/share/fonts/truetype/noto \
    && cd /usr/share/fonts/truetype/noto \
    && wget https://raw.githubusercontent.com/googlefonts/noto-emoji/master/fonts/NotoColorEmoji.ttf \
    && wget https://raw.githubusercontent.com/googlefonts/noto-emoji/master/fonts/NotoEmoji-Regular.ttf \
    && fc-cache -fv

# Run everything after as non-privileged user.
#USER pptruser
#WORKDIR /home/pptruser
#COPY puppeteerConfigFile.json /home/pptruser/.puppeteer.json
