# install chocolatey with powershell 

# choco list --localonly
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install keepassxc copyq rufus -y
choco install kindle vlc -y