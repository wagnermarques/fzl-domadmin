# fzl-domadmin
This is a bash scripts and utilities for productivity of low price
computer machines and for teachers using linux, specially fedora.


## use cases
### Transmitir para Tv 

    1) Encontre sua tv na rede sua rede

Use o comando abaixo pra encontrar os dispositivos da sua rede
Vc tem que substituir 192.168.3.0/24 pela sua rede

nmap 192.168.3.0/24

eu percebi que tinha 192.168.3.132 com a porta 1086 aberta
desconfiei que era a tv e o comando abaixo revelou isso pra mim

wgn@wgnnote:~$ sudo nmap -sV -O -p 1086 192.168.3.122
Starting Nmap 7.92 ( https://nmap.org ) at 2025-11-22 16:37 -03
Nmap scan report for 192.168.3.132
Host is up (0.0070s latency).

PORT     STATE SERVICE VERSION
1086/tcp open  upnp    Platinum upnpd (LG TV model: 32LH570B-SC; Neptune 1.1.3)
MAC Address: D0:05:2A:23:55:B3 (Arcadyan)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running: Linux 3.X
OS CPE: cpe:/o:linux:linux_kernel:3
OS details: Linux 3.2 - 3.16
Network Distance: 1 hop
Service Info: OS: Linux; Device: media device; CPE: cpe:/h:lg:32lh570b-sc, cpe:/o:linux:linux_kernel

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 25.54 seconds

    2) libere seu firewal da sua mÃ¡quina. Eu to no fedora

wgn@wgnnote:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-emacs/main/src/lispsite$ sudo firewall-cmd --permanent --add-service=minidlna
[sudo] senha para wgn: 
Warning: ALREADY_ENABLED: minidlna
success
wgn@wgnnote:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-emacs/main/src/lispsite$ sudo firewall-cmd --permanent --add-service=ssdp
success
wgn@wgnnote:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-emacs/main/src/lispsite$ 


    3) Agora seu pc precisa conseguir encontrar a tv 
sudo nmap -sn --script=broadcast-upnp-info 192.168.3.0/24

    4) http://192.168.3.122:2002/

#+name: http://192.168.3.122:2002/ xml
#+begin_src xml
This XML file does not appear to have any style information associated with it. The document tree is shown below.
<root xmlns="urn:schemas-upnp-org:device-1-0" xmlns:dlna="urn:schemas-dlna-org:device-1-0" xmlns:pnpx="http://schemas.microsoft.com/windows/pnpx/2005/11" xmlns:df="http://schemas.microsoft.com/windows/2008/09/devicefoundation">
<specVersion>
<major>1</major>
<minor>0</minor>
</specVersion>
<device>
<deviceType>urn:schemas-upnp-org:device:MediaRenderer:1</deviceType>
<friendlyName>[LG] webOS TV UP7550PSF</friendlyName>
<manufacturer>LG Electronics.</manufacturer>
<manufacturerURL>http://www.lge.com</manufacturerURL>
<modelDescription>LG WebOSTV DMRplus</modelDescription>
<modelName>LG TV</modelName>
<modelURL/>
<modelNumber>1.0</modelNumber>
<serialNumber/>
<UDN>uuid:642ed523-4b5e-7fbb-ab63-89ee394e95ef</UDN>
<pnpx:X_compatibleId>MS_DigitalMediaDeviceClass_DMR_V001</pnpx:X_compatibleId>
<pnpx:X_deviceCategory>MediaDevices</pnpx:X_deviceCategory>
<df:X_deviceCategory>Multimedia.DMR</df:X_deviceCategory>
<df:X_modelId>LG Digital Media Renderer TV</df:X_modelId>
<lge:X_LG_DLNA_DOC xmlns:lge="urn:lge-com:device-1-0">1.0</lge:X_LG_DLNA_DOC>
<dlna:X_DLNADOC xmlns:dlna="urn:schemas-dlna-org:device-1-0">DMR-1.50</dlna:X_DLNADOC>
<iconList>
<icon>
<mimetype>image/jpeg</mimetype>
<width>48</width>
<height>48</height>
<depth>24</depth>
<url>/dmrIcon_48.jpeg</url>
</icon>
<icon>
<mimetype>image/jpeg</mimetype>
<width>120</width>
<height>120</height>
<depth>24</depth>
<url>/dmrIcon_120.jpeg</url>
</icon>
<icon>
<mimetype>image/png</mimetype>
<width>48</width>
<height>48</height>
<depth>24</depth>
<url>/dmrIcon_48.png</url>
</icon>
<icon>
<mimetype>image/png</mimetype>
<width>120</width>
<height>120</height>
<depth>8</depth>
<url>/dmrIcon_120.png</url>
</icon>
</iconList>
<serviceList>
<service>
<serviceType>urn:schemas-upnp-org:service:AVTransport:1</serviceType>
<serviceId>urn:upnp-org:serviceId:AVTransport</serviceId>
<SCPDURL>/AVTransport/642ed523-4b5e-7fbb-ab63-89ee394e95ef/scpd.xml</SCPDURL>
<controlURL>/AVTransport/642ed523-4b5e-7fbb-ab63-89ee394e95ef/control.xml</controlURL>
<eventSubURL>/AVTransport/642ed523-4b5e-7fbb-ab63-89ee394e95ef/event.xml</eventSubURL>
</service>
<service>
<serviceType>urn:schemas-upnp-org:service:ConnectionManager:1</serviceType>
<serviceId>urn:upnp-org:serviceId:ConnectionManager</serviceId>
<SCPDURL>/ConnectionManager/642ed523-4b5e-7fbb-ab63-89ee394e95ef/scpd.xml</SCPDURL>
<controlURL>/ConnectionManager/642ed523-4b5e-7fbb-ab63-89ee394e95ef/control.xml</controlURL>
<eventSubURL>/ConnectionManager/642ed523-4b5e-7fbb-ab63-89ee394e95ef/event.xml</eventSubURL>
</service>
<service>
<serviceType>urn:schemas-upnp-org:service:RenderingControl:1</serviceType>
<serviceId>urn:upnp-org:serviceId:RenderingControl</serviceId>
<SCPDURL>/RenderingControl/642ed523-4b5e-7fbb-ab63-89ee394e95ef/scpd.xml</SCPDURL>
<controlURL>/RenderingControl/642ed523-4b5e-7fbb-ab63-89ee394e95ef/control.xml</controlURL>
<eventSubURL>/RenderingControl/642ed523-4b5e-7fbb-ab63-89ee394e95ef/event.xml</eventSubURL>
</service>
</serviceList>
</device>
</root>
#+end_src

    5) sudo dnf install minidlna

wgn@wgnnote:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-domadmin$ sudo systemctl enable --now minidlna
Created symlink '/etc/systemd/system/multi-user.target.wants/minidlna.service' → '/usr/lib/systemd/system/minidlna.service'.


Passo 1: Limpar a memória do MiniDLNA (O Principal)
# 1. Pare o serviço
sudo systemctl stop minidlna

# 2. Apague o banco de dados (o cérebro dele)
sudo rm -rf /var/cache/minidlna/files.db

# 3. Reinicie o serviço (ele vai criar um banco novo, limpo)
    sudo systemctl start minidlna
    
    chmod -R o+rX /home/wgn/Screencasts


## features
fzl-add-to-path
fzl-docker-change-root-dir
fzl-libvirt-install.sh
fzl-ambiente-dev-php-fpm-moodle-joomla--access-moodle
fzl-docker-phpmyadmin-star
fzl-libvirt-lsmod-kvm
fzl-ambiente-dev-php-fpm-moodle-joomla--access-phpmyadmin
fzl-docker-portainers-start
fzl-libvirt-qcow2-img-to-default-dir
fzl-ambiente-dev-php-fpm-moodle-joomla--diag
fzl-docker-prune-all
fzl-libvirt.sh
fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-joomla
fzl-docker-prune-all-containers
fzl-libvirt-start-service
fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-moodle
fzl-docker-prune-all-images-
fzl-libvirt-status-service
fzl-ambiente-dev-php-fpm-moodle-joomla.sh
fzl-docker-prune-all-networks
fzl-lsp-install-copilot-language-server.sh
fzl-ambiente-dev-php-fpm-moodle-joomla--up
fzl-docker-prune-all-volumes
fzl-android-app-list
fzl-docker-run-mysql-8
fzl-mvn
fzl-android-avd-list
fzl-eclipse-java-start
fzl-openbox-pacmanfm-foders-view-in-compact-mode.sh
fzl-android-device-list                                              fzl-eclipse-modelling-start                                          fzl-os-fed--font-intall-timesnewromman.sh
fzl-android-device-off                                               fzl-emacs.sh                                                         fzl-samba-criar-pasta-compartilhada-publica
fzl-android-device-shell                                             fzl-emacs-start                                                      fzl-samba-listar-pastas-compartilhadas
fzl-android-emulator-start                                           fzl-fedora-install-browsers.sh                                       fzl-scenebuilder-start
fzl-android-kill-emulators                                           fzl-fedora-install-browsers.sh~                                      fzl-screencast-start-ffmpeg
fzl-android-studio-start                                             fzl-ffmpeg-screencast-record                                         fzl-screenkey-install-dnf
fzl-android-upload-file                                              fzl-fonts-install-nerdfonts-firacode-fedora.sh                       fzl-screenkey-start
fzl-ansible-config--setup-ansible.cfg                                fzl-fonts-list-installled-fonts.sh                                   fzl-smbclient-listar-pastas-compartilhadas-remotas
fzl-ansible--setup-ansible-cfg                                       fzl-fonts-list-installled-fonts.sh~                                  fzl-smb-criar-pasta-compartilhada-publica.sh
fzl-audio-noise-reduce--of-mp4                                       fzl-google-drive-start                                               fzl-squirrelsql-start
fzl-bash-config--git-colors                                          fzl-gradle-setup-7.4.2                                               fzl-sts-start
fzl-bash-config--prompt-red2yellow                                   fzl-gradle-setup-8.11.1                                              fzl-telegram-start
fzl-bash-config--prompt-shortened                                    fzl-intellij-idea-start                                              fzl-tomcat9-start
fzl-battery-info                                                     fzl-intellij-start                                                   fzl-tomcat9-stop
fzl-battery-info-verbose                                             fzl-java                                                             fzl-touchpad-enable-click-ou-tap
fzl-bruno-start                                                      fzl-javafx-scenebuilder-install-from-jar                             fzl-umldesigner-start
fzl-compare-dir-show-files-diference                                 fzl-javafx-scenebuilder-start                                        fzl-vscode-setup-chrome-sandbox
fzl-convert-audio--of-mp3                                            fzl-java-setup--oracle-jdk-17                                        fzl-vscode-start
fzl-convert-txt-2-pdf                                                fzl-java-setup--oracle-jdk-21                                        fzl-zotero-start
fzl-convert-video-gif-anim                                           fzl-java-setup--oracle-jdk-8                                         
fzl-convert-video-mp4                                                fzl-java-version-setup                                               





