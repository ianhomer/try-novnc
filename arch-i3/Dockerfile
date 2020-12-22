FROM archlinux:latest

# Base arch install
RUN pacman -Syu --noconfirm \
      archlinux-keyring \
      base-devel \
      git \
      net-tools \
      python-pip \
      supervisor \
      vim

# User set up
RUN mkdir /app
RUN groupadd us && \
    useradd -m -d /app -g us me
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me

RUN chown -R me:us /app

# GUI set up
RUN pacman -Syu --noconfirm \
      conky \
      kitty \
      dmenu \
      xf86-video-dummy \
      xorg \
      xorg-apps \
      xorg-server \
      xorg-xinit

# VNC set up
RUN pacman -Syu --noconfirm \
      x11vnc

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

# i3 window manager
RUN pacman -Syu --noconfirm \
      i3

RUN pacman -S --noconfirm --needed \
      ttf-inconsolata

WORKDIR /app
ENV HOME=/app \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    DISPLAY=:0.0

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY 10-headless.conf /etc/X11/xorg.conf.d/10-headless.conf
COPY .xinitrc /app/.xinitrc
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 9876
