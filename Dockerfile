FROM ubuntu:18.04

# Virtuelles Display
ENV DISPLAY :99

# Grafische Oberfläche ( xfce4, xfce4-terminal ), CLI-Download wget, Browser firefox und Virtueller Displaytreiber xvfb installieren
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y xvfb xfce4 xfce4-terminal wget firefox

# Tigervnc für lokalen Zugriff herunterladen und entpacken
RUN wget -qO- https://sourceforge.net/projects/tigervnc/files/stable/1.10.1/tigervnc-1.10.1.x86_64.tar.gz | tar xz --strip 1 -C /

# Installation von AnyDesk für Fernzugriff aus dem Internet
RUN wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
RUN echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y anydesk

RUN echo "AnyDesk2023!" | anydesk --set-password

# Lokalen Nutzer anlegen ( root sollte unter keinen Umständen genutzt werden ! )
RUN useradd anydesk
USER anydesk
WORKDIR /home/anydesk

# Automatisch den Port 5901 für VNC freigeben
EXPOSE 5901

# VNC-Startskript kopieren und beim Start des Containers ausführen
COPY vnc_startup.sh /
ENTRYPOINT ["/vnc_startup.sh"]