FROM debian:buster

RUN set -ex
RUN apt-get update

# Core
RUN apt-get install -y \
      bash \
      git \
      net-tools

# Extra
RUN apt-get install -y \
      fluxbox \
      novnc \
      supervisor \
      x11vnc \
      xvfb

RUN apt-get install -y vim
RUN apt-get install -y procps

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=800 \
    DISPLAY_HEIGHT=600

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord"]
EXPOSE 9873
