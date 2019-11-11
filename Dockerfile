FROM base/archlinux:latest

ARG USERNAME=arch
ARG PASSWORD=pass

ENV HOME /home/${USERNAME}

RUN pacman -Syu --noconfirm
RUN pacman -S base base-devel git --noconfirm

RUN echo archhost > /etc/hostname
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen
RUN export LANG=C
RUN echo LANG=ja_JP.UTF-8 > /etc/locale.conf

RUN useradd -m -G wheel -s /bin/bash ${USERNAME}
RUN echo "root:${PASSWORD}" | chpasswd
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo

RUN su - ${USERNAME}
RUN git clone https://aur.archlinux.org/yay.git && cd /home/${USERNAME}/yay && makepkg -si
RUN git clone git://github.com/ttaki/dotfiles
