FROM archlinux:latest

# Base arch install
#
# sudo, binutils and fakeroot => makepkg install of novnc
RUN pacman -Syu --noconfirm \
      archlinux-keyring \
      binutils \
      fakeroot \
      git \
      python-pip \
      sudo \
      supervisor \
      vim

# User set up
RUN groupadd us && \
    useradd -m -d /app -g us me
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me

RUN chown -R me:us /app

# VNC set up
RUN pacman -Syu --noconfirm \
      x11vnc

COPY 10-headless.conf /etc/X11/xorg.conf.d/10-headless.conf

# Web sockify dependency recommendation
RUN pip install numpy

USER me

WORKDIR /app
RUN mkdir .gnupg && \
    touch .gnupg/gpg.conf && \
    echo "keyserver-options auto-key-retrieve" > .gnupg/gpg.conf

RUN git clone https://aur.archlinux.org/websockify.git /app/websockify
WORKDIR /app/websockify
RUN makepkg --noconfirm --syncdeps --rmdeps --install --clean

RUN git clone https://aur.archlinux.org/novnc.git /app/novnc
WORKDIR /app/novnc
RUN makepkg --noconfirm --syncdeps --rmdeps --install --clean

USER root

# GUI set up
RUN pacman -Syu --noconfirm \
      kitty \
      ttf-inconsolata \
      xf86-video-dummy \
      xorg-server \
      xorg-xinit

# i3 window manager
RUN pacman -Syu --noconfirm \
      i3

WORKDIR /app
ENV HOME=/app \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    DISPLAY=:0.0

COPY supervisord.conf /app/
COPY .xinitrc /app/
CMD ["/usr/bin/supervisord","-c", "/app/supervisord.conf"]
EXPOSE 9876
