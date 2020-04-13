# Minimal Node image to run Angular commands.
FROM node:13.2.0-alpine

# Installs latest Chromium package.
RUN apk add --no-cache chromium \
                       chromium-chromedriver \
                       git \
                       bash \
                       iproute2 \
                       procps \
 # Install basic lint utils for Node.js
 && npm install -g tslint typescript \
 # Remove the npm cache to shrink the image (~ 20 MB)
 && rm -fr /root/.npm

ARG USERNAME=node

# Add sudo support for the non-root user
RUN apk add --no-cache sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_DRIVER=/usr/bin/chromedriver \
    CHROME_PATH=/usr/lib/chromium/ \
    SHELL=/bin/bash
