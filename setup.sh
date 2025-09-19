# Instance type: m5/xlarge (vcpu 4 / 16 GiB ram)
# Operating System: Ubuntu 20.04
# Disk Storage 100 Gib SSD


echo "###############################################################"
echo "# Script: Setup observability instance                        #"
echo "# Description: To create a observability instance.            #"
echo "# Created date: 19/09/25                                      #"
echo "# Arthur: Alex J Davison (alexd@splunk.com/alexdav@cisco.com) #"
echo "# Version: 0.0.1                                              #"
echo "# Starting...                                                 #"
echo "###############################################################"
echo ""

echo "###############"
echo "# OS Commands #"
echo "###############"
echo ""

echo "Update OS"
sudo apt-get update
echo ""

echo "####################"
echo "# Install microk8s #"
echo "####################"
echo ""

echo "Install microk8s"
sudo snap install microk8s --classic --channel=1.25/stable
echo ""

echo "Get information about microk8s"
snap info microk8s
echo ""

echo "Enable DNS"
sudo microk8s enable dns 
echo ""

echo "Enable dashboard"
sudo microk8s enable dashboard
echo ""

echo "Enable storage"
sudo microk8s enable storage
echo ""

echo "Enable storage hostpath"
sudo microk8s enable storage hostpath-storage rbac ingress
echo ""

echo "Check microk8s"
sudo microk8s status
echo ""

echo "microk8s inspect for a deeper inspection"
sudo microk8s inspect
echo ""

echo "#########################"
echo "# Setup microk8s config #"
echo "#########################"
echo ""

echo "Go to home"
cd $HOME
echo ""

echo "Create .kube directory"
mkdir .kube
echo ""

echo "Go into .kube directory"
cd .kube
echo ""

echo "Change user settings"
sudo usermod -a -G microk8s splunker
echo ""

echo "Change folder permission"
sudo chown -f -R splunker ~/.kube
echo ""

echo "Create new group"
newgrp microk8s
echo ""

echo "Load micok8s config"
microk8s config > config
echo ""

echo "Exit"
exit
echo ""

echo "################"
echo "# Install Brew #"
echo "################"
echo ""

echo "Install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo ""

echo "Start brew installation"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo ""

echo "Update build essential"
sudo apt-get install build-essential
echo ""

echo "Install gcc"
brew install gcc
echo ""

echo "################"
echo "# Install helm #"
echo "################"
echo ""

echo "Installing helm"
sudo snap install helm --classic
echo ""

echo "Starting installing helm"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo ""

echo "Update transport https"
sudo apt-get install apt-transport-https --yes
echo ""

echo "Installation step of helm"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
echo ""

echo "Install helm"
sudo apt-get install helm
echo ""

echo "################"
echo "# Create alias #"
echo "################"
echo ""

echo "Create alias for helm"
echo 'alias helm=microk8s.helm' | sudo tee -a  /etc/bash.bashrc
echo ""

echo "Create alias for kubectl"
echo 'alias kubectl=microk8s.kubectl' | sudo tee -a  /etc/bash.bashrc
echo ""

echo "Apply alias"
. /etc/bash.bashrc
echo ""