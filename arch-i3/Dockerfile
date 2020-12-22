FROM archlinux:latest

# Base arch
RUN pacman -Syu --noconfirm \
      archlinux-keyring \
      base-devel \
      git \
      net-tools \
      python-pip \
      vim

# Web sockify recommendation
RUN pip install numpy

# Windows base
RUN pacman -Syu --noconfirm \
      conky \
      dmenu \
      xorg \
      xorg-apps \
      xorg-server \
      xorg-xinit

# VNC layer
RUN pacman -Syu --noconfirm \
      x11vnc

# Docker spin up
RUN pacman -Syu --noconfirm \
      supervisor

RUN groupadd admin && \
    useradd -m -g admin admin
RUN echo "admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin

RUN mkdir /app
RUN chown -R admin:admin /app

USER admin
WORKDIR /home/admin

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
WORKDIR /app

# i3
RUN pacman -Syu --noconfirm \
      i3

# experiments
RUN pacman -Syu --noconfirm \
      xf86-video-dummy

RUN pacman -S --noconfirm --needed \ 
  noto-fonts \
  ttf-ubuntu-font-family \
  ttf-dejavu \
  ttf-freefont \
  ttf-liberation \
  ttf-droid \
  ttf-inconsolata \
  ttf-roboto \
  terminus-font \
  ttf-font-awesome

RUN pacman -S --noconfirm \
  kitty

ENV HOME=/root \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=800 \
    DISPLAY_HEIGHT=600

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY 10-headless.conf /etc/X11/xorg.conf.d/10-headless.conf
COPY .xinitrc /root/.xinitrc

CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 9873



