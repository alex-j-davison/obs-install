# Instance type: m5/xlarge (vcpu 4 / 16 GiB ram)
# Operating System: Ubuntu 20.04
# Disk Storage 100 Gib SSD


echo "###############################################################"
echo "# Script: Step-1 Setup observability instance                 #"
echo "# Description: To create a observability instance.            #"
echo "# Created date: 19/09/25                                      #"
echo "# Arthur: Alex J Davison (alexdav@cisco.com)                  #"
echo "# Version: 0.0.1                                              #"
echo "# Starting...                                                 #"
echo "###############################################################"
echo ""
echo "#############"
echo "# Update OD #"
echo "#############"
echo ""
echo "Step 1/1: Updating OS"
sudo apt-get update
echo ""
echo "####################"
echo "# Install microk8s #"
echo "####################"
echo ""
echo "Step 1/5: Install microk8s"
sudo snap install microk8s --classic --channel=1.25/stable
echo "Step 2/5: Enable DNS"
sudo microk8s enable dns 
echo "Step 3/5: Enable dashboard"
sudo microk8s enable dashboard
echo "Step 4/5: Enable storage"
sudo microk8s enable storage
echo "Step 5/5: Enable storage path"
sudo microk8s enable storage hostpath-storage rbac ingress
echo ""
echo "#################"
echo "# Creates alias #"
echo "#################"
echo ""
echo "Step 1/3: Add helm alias"
echo 'alias helm=microk8s.helm' | sudo tee -a  /etc/bash.bashrc
echo "Step 2/3: Add kubectl alias"
echo 'alias kubectl=microk8s.kubectl' | sudo tee -a  /etc/bash.bashrc
echo "Step 3/3: Load alias"
source . /etc/bash.bashrc
echo ""
echo "##########"
echo "# Reboot #"
echo "##########"
echo ""
echo "Step 1/1: Reboot"
sudo reboot