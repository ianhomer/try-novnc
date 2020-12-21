FROM archlinux:latest

RUN pacman -Syu --noconfirm \
      fluxbox \
      supervisor \
      x11vnc \
      xorg-server-xvfb \
      xorg-xinit \
      net-tools \
      git \
      vim

RUN pacman -Syu --noconfirm \
      archlinux-keyring \
      base-devel \
      xorg \
      python-pip

RUN pip install numpy

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

ENV HOME=/root \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=800 \
    DISPLAY_HEIGHT=600

COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 9874
EXPOSE 5908
EXPOSE 5900


