# pandoc-latex image

FROM pandoc/latex:2.11.2

LABEL org.opencontainers.image.source https://github.com/goffinet/pandoc-latex

ENV CHROME_BIN="/usr/bin/chromium-browser"
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN apk add --update \
    chromium \
    npm \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    yarn \
    ttf-ubuntu-font-family

RUN npm install -g mermaid-filter@1.4.5 --unsafe-perm=true

# Install Tex Gyre Termes font
RUN tlmgr update --self && tlmgr install tex-gyre tex-gyre-math selnolig

# Install Noto Color Emoji
RUN mkdir -p /usr/share/fonts/truetype/noto \
    && cd /usr/share/fonts/truetype/noto \
    && wget https://raw.githubusercontent.com/googlefonts/noto-emoji/master/fonts/NotoColorEmoji.ttf \
    && wget https://raw.githubusercontent.com/googlefonts/noto-emoji/master/fonts/NotoEmoji-Regular.ttf \
    && fc-cache -fv
