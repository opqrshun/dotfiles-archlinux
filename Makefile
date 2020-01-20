export PATH := ${HOME}/.local/bin:${HOME}/.node_modules/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/bin/core_perl:${HOME}/bin
export GOPATH := ${HOME}

DOTPATH=${PWD}
init: ## Initial deploy dotfiles
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# for f in .??*; do\
	# 		[ "$$f" = ".git" ] && continue

	# 		ln -snfv "${PWD}/$$f" "${HOME}"/"$$f"
			
	# done

	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.imwheelrc ${HOME}/.imwheelrc
	ln -vsf ${PWD}/.bashrc ${HOME}/.bashrc
	# ln -vsf ${PWD}/.config ${HOME}/.config
	ln -vsf ${PWD}/.bash_profile ${HOME}/.bash_profile
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.imwheelrc ${HOME}/.imwheelrc

	mkdir -p ${HOME}/work
	mkdir -p ${HOME}/work/project
	echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

vscode_setup:
	ln -vsf ${HOME}/Dropbox/vscode/settings.json ${HOME}/.config/Code/User/settings.json
	ln -vsf ${HOME}/Dropbox/vscode/keybindings.json ${HOME}/.config/Code/User/keybindings.json
	# ln -vsf ${HOME}/Dropbox/autostart/apparmor-notify.desktop ${HOME}/.config/autostart/apparmor-notify.desktop
	ln -vsf ${HOME}/Dropbox/autostart/imwheel.desktop ${HOME}/.config/autostart/imwheel.desktop
	ln -vsf ${HOME}/Dropbox/autostart/copyq.desktop ${HOME}/.config/autostart/copyq.desktop
	ln -vsf ${HOME}/Dropbox/autostart/imwheelrc.desktop ${HOME}/.config/autostart/imwheelrc.desktop
	
	
	# bash setup_vscode.sh
	# ln -s ~/MEGAsync/mydev/ansible/ansible/ ~/ansible
	# ln -s ~/MEGAsync/mydev/ ~/mydev
	# ln -s ~/MEGAsync/mydev/docker ~/mydocker
	# ln -s ~/MEGAsync/mydev/project ~/myproject
	# ln -s ~/MEGAsync/mydev/auto_tools ~/auto_tools


init_wsl: ## Initial deploy dotfiles
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# for f in .??*; do\
	# 		[ "$$f" = ".git" ] && continue

	# 		ln -snfv "${PWD}/$$f" "${HOME}"/"$$f"
			
	# done

	# ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.imwheelrc ${HOME}/.imwheelrc
	ln -vsf ${PWD}/.bashrc ${HOME}/.bashrc
	ln -vsf ${PWD}/.config ${HOME}/.config
	ln -vsf ${PWD}/.bash_profile ${HOME}/.bash_profile
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.imwheelrc ${HOME}/.imwheelrc

	mkdir -p ${HOME}/work
	mkdir -p ${HOME}/work/project
	echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
# GRUB_DISABLE_SUBMENU=y サブメニューを無効にしておく
# 設定ファイル生成し直す
# grub-mkconfig -o /boot/efi/EFI/grub/grub.cfg

# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
# nkf文字コード変換コマンド

# nkf snapd
# bind-tools dnstoolsなど
# sshpass sshログイン自動化
base_install:
	sudo pacman -Syu base base-devel \
		zsh ansible tmux wget vim neovim \
		bind-tools nmap \
		cmake lsof htop \
		pwgen \
		nodejs yarn php composer python go rust r \
		mariadb \
		mysql-python jdk-openjdk shellcheck sshpass\
		--noconfirm

	# tmux plugin manager
	# tmux-loggingとか入れる
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# linux-lts 安定カーネル
arch_setup:
	sudo pacman -Syu gnome gnome-tweaks\
		linux-lts --noconfirm

wsl_setup:
	yay -Syu genie-systemd dbus-x11 --noconfirm
	pacman -Syu xfce4 --noconfirm

#zeal document browser 言語リファレンス
# zenity 手軽にguiアプリが作れるやつ
# meld diff gui tool
gui_install:
	sudo pacman -Syu vinagre\
		tilix copyq imwheel\
		keepassxc\
		filezilla \
		zenity \
		vlc libreoffice-fresh pinta meld\
		zeal
		--noconfirm

yay:
	yay -Syu ibus-mozc mozc otf-ipaexfont ttf-migu ttf-ricty \
	 visual-studio-code-bin chrome-gnome-shell-git \
	 dropbox nautilus-dropbox github-desktop slack-desktop nkf postman\
	 rednotebook zoom openprinting-ppds-postscript-ricoh \
	 google-chrome \
	 --noconfirm
 
node_setup:
	sudo pacman -Syu yarn --noconfirm
	mkdir -p ${HOME}/.node_modules
	yarn global add n
	yarn global add @openapitools/openapi-generator-cli
	

python_setup:
	python -m venv ${HOME}/venv/pydev
	# source ${HOME}/venv/pydev/bin/activate
	#pip実行
	pip

pip:
	${HOME}/venv/pydev/bin/pip install --user --upgrade pip
	${HOME}/venv/pydev/bin/pip install -r requirements.txt


# TODO configファイル
cups:
	sudo pacman -Syu cups cups-pdf system-config-printer --noconfirm
	sudo systemctl enable org.cups.cupsd.service docker
	sudo systemctl start org.cups.cupsd.service docker

# powertopも入れる？
tlp: # battery省電力設定
	sudo pacman -Syu tlp --noconfirm
	# sudo ln -vsf ${PWD}/etc/default/tlp /etc/default/tlp
	sudo systemctl enable tlp.service
	sudo systemctl enable tlp-sleep.service

docker:
	sudo pacman -Syu docker docker-compose --noconfirm
	sudo systemctl enable docker
	sudo systemctl start docker

podman:
	sudo pacman -Syu podman --noconfirm
	sudo systemctl enable io.podman.service
	sudo systemctl start io.podman.service


################## 

usbguard:
	sudo pacman -Syu usbguard usbguard-qt
	sudo systemctl enable usbguard
	sudo systemctl start usbguard
	# sudo usbguard-applet-qt でusbチェック

antivirus:
	sudo pacman -Syu clamav clamtk
	sudo freshclam
	sudo systemctl enable clamav-daemon.service
	sudo systemctl start clamav-daemon.service
# nftablesがあるのでipset,ebtablesは不要？
firewalld: # battery省電力設定
	sudo pacman -Syu firewalld --noconfirm
	# sudo pacman Syu ipset ebtables
	# -> null
	sudo systemctl mask ip6tables.service iptables.service 
	sudo systemctl enable firewalld
	sudo systemctl start firewalld

security: #apparmor audit
	
	# apparmor
	# カーネルパラメータ設定
	#/etc/default/grub
	# GRUB_CMDLINE_LINUX_DEFAULTに以下追加
	#GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet apparmor=1 security=apparmor"

	sudo pacman Syu apparmor
	sudo systemctl enable apparmor.service

	# まず学習モードにしておく
	# sudo aa-complain /etc/apparmor.d/*
	# sudo aa-enforce /etc/apparmor.d/*
	# sudo systemctl reload apparmor.service

	# # audit
	sudo pacman -Syu audit --noconfirm
	sudo systemctl enable auditd
	sudo systemctl start auditd

	# ユーザ taki をグループ audit に追加
	groupadd -r audit
	sudo gpasswd -a taki audit

	# /etc/audit/auditd.confに以下設定
	# log_group = audit

	# /etc/apparmor/parser.confに以下をアンコメント
	# ## Turn creating/updating of the cache on by default
	# write-cache

vagrant:
	sudo pacman -Syu vagrant virtualbox-host-modules-arch virtualbox-guest-iso --noconfirm
	yay -Syu virtualbox-ext-oracle --noconfirm
	vagrant plugin install vagrant-vbguest
	vagrant plugin install vagrant-disksize
	vagrant vbguest --do install
	sudo  gpasswd -a ${USER} vboxusers
	
arch_virtualbox: ## nat
	ip link set enp0s3 up
	systemctl enable dhcpcd.service
	systemctl start dhcpcd.service
	systemctl enable systemd-networkd.service systemd-resolved.service
	systemctl start systemd-networkd.service systemd-resolved.service

# ゲスト側
vagrantguest:
	sudo pacman Syu virtualbox-guest-utils	
	
###################################
ansible_setup:
	ansible-galaxy install nginxinc.nginx
	ansible-galaxy install geerlingguy.apache                                                                               
	ansible-galaxy install geerlingguy.mysql                                                                               
	ansible-galaxy install geerlingguy.phpmyadmin                                                                               

#不要
execansible:
	ansible-playbook -i ansible/local ansible/site.yml --tags setup --ask-become-pass


something: cups tlp

vm_setup: vagrant arch_virtualbox

security_setup: firewalld antivirus usbguard security

all_install: arch_setup base_install gui_install docker yay python_setup node_setup ansible_setup vm_setup security_setup something

all_install_wsl: wsl_setup base_install gui_install docker python_setup node_setup ansible_setup vagrant antivirus something








######################################################

ubuntu:
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt -y python-setuptools
	sudo apt -y selinux
	# https://packages.ubuntu.com/ja/xenial/build-essential
	sudo apt -y build-essential
	sudo apt -y zsh tmux git nmap htop neovim
	# nkf文字コード変換コマンド
	sudo apt install -y tilix imwheel nkf pwgen

	# ansible
	sudo apt install -y software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt -y install ansible
	
	# copyq
	sudo add-apt-repository ppa:hluk/copyq
	sudo apt update
	sudo apt install -y copyq

	sudo apt install -y clamav clamav-daemon
	sudo apt install -y filezilla virtualbox virtualbox-ext-pack
	sudo snap install vscode --classic

	# 日本語化
	# thema 外観からfontを選択
	sudo apt install -y language-pack-ja-base language-pack-ja ibus-mozc fonts-ipafont fonts-ipaexfont
	sudo apt install -y manpages-ja manpages-ja-dev
	# sudo localectl set-locale LANG=en_US.UTF-8 LANGUAGE="en_US.UTF-8"
	sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
	source /etc/default/locale

	sudo apt install -y nodejs npm

	# chrome は落としてくるか
	#dpkg -i chrome_path

# fedora:
# 	sudo dnf update
# 	sudo dnf install -y ansible tilix tmux imwheel nkf copyq snapd vim neovim\
# 	 python-setuptools python-devel cmake lsof htop filezilla pwgen vagrant\
# 	 zsh ibus-mozc git-gui\
# 	bzip2-devel gdbm-devel libffi-devel libuuid-devel ncurses-devel \
# 	openssl-devel readline-devel sqlite-devel tk-devel wget xz-devel \
# 	zlib-devel gcc gcc-c++ boost-devel gnome-tweaks\
# 	nmap firewall-config\
# 	composer

# 	#docker
# 	sudo dnf -y remove docker \
#                   docker-client \
#                   docker-client-latest \
#                   docker-common \
#                   docker-latest \
#                   docker-latest-logrotate \
#                   docker-logrotate \
#                   docker-selinux \
#                   docker-engine-selinux \
#                   docker-engine

# 	sudo dnf -y install dnf-plugins-core
# 	sudo dnf config-manager \
# 			--add-repo \
# 			https://download.docker.com/linux/fedora/docker-ce.repo
			
# 	sudo dnf install -y docker-ce docker-ce-cli containerd.io

# 	# docer-compose common
# 	curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$$(uname -s)-$$(uname -m)" \
# 			-o /usr/local/bin/docker-compose
# 	chmod +x /usr/local/bin/docker-compose
# 	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# 	# node
# 	curl -sL https://rpm.nodesource.com/setup_12.x | bash -
# 	sudo dnf install nodejs

# 	# code https://code.visualstudio.com/docs/setup/linux
# 	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#   sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
# 	dnf check-update
#   sudo dnf install-y code



	







