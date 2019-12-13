FROM archlinuxjp/archlinux

ARG USERNAME=arch
ARG PASSWORD=pass

ENV HOME /home/${USERNAME}

RUN pacman -Syu --noconfirm
RUN pacman -S base base-devel git --noconfirm

RUN echo 'Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
# RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

RUN echo archhost > /etc/hostname
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen
RUN echo LANG=en_US.UTF-8 > /etc/locale.conf



RUN useradd -m -G wheel -s /bin/bash ${USERNAME}
RUN echo "root:${PASSWORD}" | chpasswd
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo

RUN su - ${USERNAME}
RUN git clone https://aur.archlinux.org/yay.git && cd /home/${USERNAME}/yay && makepkg -si
RUN git clone git://github.com/ttaki/dotfiles
