FROM ubuntu:22.04

RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    wget curl \
    python3 python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# تثبيت Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb

# تثبيت noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify

EXPOSE 8080

CMD vncserver :1 -geometry 1280x720 -depth 24 && \
    /opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 8080
