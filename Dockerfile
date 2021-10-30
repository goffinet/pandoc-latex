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
    noto-fonts

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    PATH="/data/node_modules/.bin:${PATH}"

# Add user so we don't need --no-sandbox.
RUN chmod o+w /opt/texlive/texdir/texmf-var

# Puppeteer v5.2.1 works with Chromium 85.
RUN yarn add eslint puppeteer@5.2.1 mermaid-filter

# Install Tex Gyre Termes font
RUN tlmgr update --self && tlmgr install tex-gyre tex-gyre-math selnolig

# Install Noto Color Emoji
RUN fc-cache -fv
