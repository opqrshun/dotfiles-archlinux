#!/usr/bin/env bash
function setupNode() {
  pacman -Syu nodejs yarn npm --noconfirm
  mkdir -p "$HOME/.node_modules"
	yarn global add n
	yarn global add @openapitools/openapi-generator-cli
}

#!/usr/bin/env bash
function setupPython() {
  python -m venv ${HOME}/venv/pydev
  ${HOME}/venv/pydev/bin/pip install --user --upgrade pip
	${HOME}/venv/pydev/bin/pip install -r requirements.txt
}

function setupDocker() {
  pacman -Syu docker docker-compose --noconfirm
	systemctl enable docker
	systemctl start docker
}

# function setupPodman() {
#   pacman -Syu podman --noconfirm
# 	systemctl enable io.podman.service
# 	systemctl start io.podman.service
# }

function setupAnsible() {
  pacman -Syu ansible --noconfirm
  ansible-galaxy install nginxinc.nginx
	ansible-galaxy install geerlingguy.apache                                                                               
	ansible-galaxy install geerlingguy.mysql                                                                               
	ansible-galaxy install geerlingguy.phpmyadmin     
}

# function setupUsbguard() {
#   pacman -Syu usbguard usbguard-qt
# 	systemctl enable usbguard
# 	systemctl start usbguard
# }

function setupAntivirus() {
  pacman -Syu clamav clamtk
	freshclam
	systemctl enable clamav-daemon.service
	systemctl start clamav-daemon.service
}


function setupTlp() {
  pacman -Syu tlp --noconfirm
	# ln -vsf ${PWD}/etc/default/tlp /etc/default/tlp
	systemctl enable tlp.service
	systemctl enable tlp-sleep.service
}

function setupCups() {
  # TODO configファイル
	yay -Syu openprinting-ppds-postscript-ricoh --noconfirm
  pacman -Syu cups cups-pdf system-config-printer --noconfirm
	systemctl enable org.cups.cupsd.service docker
	systemctl start org.cups.cupsd.service docker
}



# function setupApparmor() {
#   # apparmor
# 	# setup kernel param
# 	#/etc/default/grub
# 	#GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet apparmor=1 security=apparmor"

# 	pacman Syu apparmor
# 	systemctl enable apparmor.service
# }

function setupFirewalld() {
  # nftables 
  # is ipset and ebtables necessary?
  pacman -Syu firewalld --noconfirm
	# pacman Syu ipset ebtables
	# -> null
	systemctl mask ip6tables.service iptables.service 
	systemctl enable firewalld
	systemctl start firewalld
}

# function setupVagrant() {
#   pacman -Syu vagrant virtualbox-host-modules-arch virtualbox-guest-iso --noconfirm
# 	yay -Syu virtualbox-ext-oracle --noconfirm
# 	vagrant plugin install vagrant-vbguest
# 	vagrant plugin install vagrant-disksize
# 	vagrant vbguest --do install
# 	 gpasswd -a $USER vboxusers
# }

# function setupVirtualbox() {
#   ip link set enp0s3 up
# 	systemctl enable dhcpcd.service
# 	systemctl start dhcpcd.service
# 	systemctl enable systemd-networkd.service systemd-resolved.service
# 	systemctl start systemd-networkd.service systemd-resolved.service
# }

# function setupSecurity() {
#   # audit
#   pacman -Syu audit --noconfirm
# 	systemctl enable auditd
# 	systemctl start auditd

#   # add user to audit
# 	groupadd -r audit
# 	gpasswd -a taki audit
# }


setUpNode
setupDocker
setupAnsible
setupAntivirus
setupFirewalld
# setupTlp