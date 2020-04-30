#!/bin/bash

HELP="Usage: sudo ./packages.sh <operation> [...]
Automatically install Arch Linux packages

operations:
    -a           installs AUR packages
    -g           installs AUR packages
    -t <options> installs packages of GUI or CLI

Examples:
$ sudo ./packages.sh -at GUI
$ sudo ./packages.sh -a -t cli"

source $(dirname "$0")/shared.sh

if [ -z "$SUDO_USER" ]; then
    echo "$HELP"
    exit 1
fi

aurFlag=
typeFlag=
gnomeFlag=
while getopts agt: name
do
    case $name in
        a) aurFlag=1;;
        g) gnomeFlag=1;;
        t) typeFlag=1
           typeVal=$(echo "$OPTARG" | tr '[:upper:]' '[:lower:]');;
        *) echo "$HELP"
           exit 2;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    echo "$HELP"
    exit 1
fi

BASE_PACKAGES=(
    'acpi'
    'atool'
    'bat'
    'blueman'
    'bluez-utils'
    'cmus'
    'curl'
    'dhcpcd'
    # 'ffmpegthumbnailer'
    'firewalld'
    'fd' #find
    'fuse2'
    'fzf'
    'git'
    'highlight'
    'htop'
    'jq'
    'less'
    'lsd'
    'mediainfo'
    'neofetch'
    'odt2txt'
    'openvpn'
    'openssh'
    'pacman-contrib'
    'poppler'
    'ranger'
    'ripgrep' # recursively searches directorys
    'tmux'
    'tree'
    'tig' #git
    'tldr' #man usage comunity
    # 'usbguard'
    # 'weechat'
    'whois'
    'xterm'
    'z'
    'zsh'

    'wget'
    'neovim'
    'bind-tools'
    'nmap'
    'cmake'
    'lsof'
    'pwgen'

    # language
    'php'
    'composer'
    'python'
    'rust'
    'r'
    'ruby'
    'lua'

    'mariadb'
    'mysql-python'
    'jdk-openjdk'

    'cloc' #counts blank lines ..etc
    'hub' #github cli
    'shellcheck'
    'sshpass'
	'doxygen'
    'graphviz'
    'ansible'
	'terraform'
	'aws-cli'
)

CLI_PACKAGES=(
    'elinks'
)

GUI_PACKAGES=(
    'adapta-gtk-theme'
    'adobe-source-code-pro-fonts'
    # 'terminus-font'
    'tamsyn-font'
    'alacritty'
    'picom'
    'discount'
    'evince'
    # 'firefox'
    'light'
    'npm'
    'papirus-icon-theme'
    'vinagre' #vnc
    'imwheel'
    'keepassxc'
    'filezilla'
    'zenity' #create gui app
    'libreoffice-fresh'
    'pinta'
    'meld'
    'zeal' # lang reference
)

AUR_PACKAGES=(
    'conky-lua' # https://wiki.archlinux.jp/index.php/Conky
    # 'gotop'
    'lazygit'
    'lazydocker'
    'nerd-fonts-source-code-pro'
    'siji-git'
    # 'uzbl-tabbed'
    
    'ibus-mozc'
    'mozc'
    'otf-ipaexfont'
    'ttf-migu'
    'ttf-ricty'
    'nkf'
    'noti' # monitor a process and trigger a notification
    'postman'
    # 'haskell-ide-engine'
    'visual-studio-code-bin'
    'google-chrome'
    'dropbox'

    # 'rednotebook'
    'postman'
    'redshift'
    'zoom'
)

function installAurPackages() {
    if [ -z "$aurFlag" ]; then
        return 0
    fi
    banner "I will install the AUR packages"
    packageIterator "yay" "${AUR_PACKAGES[@]}"
}

function installYay() {
    if pacman -Qs yay > /dev/null ; then
        return 0
    fi
    sudo -u "$SUDO_USER" -- sh -c "
    git clone https://aur.archlinux.org/yay.git;
    cd yay || return;
    yes | makepkg -si"
}

function setUPZsh() {
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    chsh -s /bin/zsh

    # install pure prompt
    yarn global add pure-prompt
}

function installSpaceVim() {
    curl -sLf https://spacevim.org/install.sh | bash
}

function configurePacman() {
    sed -i 's/#Color/Color\nILoveCandy/g' /etc/pacman.conf
    sed -i 's/#TotalDownload/TotalDownload/g' /etc/pacman.conf
}

function installPackages() {
    banner "I will install the base system"
    configurePacman
    packageIterator "pacman" "${BASE_PACKAGES[@]}"

    if [ "$typeVal" == 'cli' ]; then
        banner "I will install the CLI packages"
        packageIterator "pacman" "${CLI_PACKAGES[@]}"
    elif [ "$typeVal" == 'gui' ]; then
        banner "I will install the GUI packages"
        packageIterator "pacman" "${GUI_PACKAGES[@]}"
    fi

    installYay
}

if [ -z "$typeFlag" ]; then
    banner "Packages can't be blank" "warn"
    exit 1
fi

if [ "$typeVal" != 'cli' ] && [ "$typeVal" != 'gui' ]; then
    banner "Invalid packages" "warn"
    exit 1
fi

if [ "$typeVal" == 'gui' ]; then
    AUR_PACKAGES+=('bibata-cursor-theme')
fi

if [ "$(uname -m)" == 'x86_64' ]; then
    BASE_PACKAGES+=('acpi'
                    'reflector'
                    'playerctl'
                    'pulseaudio'
                    'pulseaudio-alsa'
                    'pulseaudio-bluetooth'
                    )
    GUI_PACKAGES+=('pinta'
                   'pavucontrol'
                   'vlc'
    ) 
    AUR_PACKAGES+=('pulseaudio-ctl')
fi

if [ -n "$gnomeFlag" ]; then
    GUI_PACKAGES+=('gnome'
                    'gnome-tweaks')

    AUR_PACKAGES+=(
        'gnome-shell-extension-system-monitor-git'
        'chrome-gnome-shell-git'
                    'nautilus-dropbox'
                    'slack-desktop')
fi

installPackages
installAurPackages
setUPZsh
installSpaceVim

banner "Done :)"
