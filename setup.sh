# Instance type: m5/xlarge (vcpu 4 / 16 GiB ram)
# Operating System: Ubuntu 20.04
# Disk Storage 100 Gib SSD

echo "###############################################################"
echo "# Script: Step-1 Setup observability instance                 #"
echo "# Description: To create a observability instance.            #"
echo "# Created date: 19/09/25                                      #"
echo "# Arthur: Alex J Davison (alexdav@cisco.com)                  #"
echo "# Version: 1.0.0                                              #"
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
. /etc/bash.bashrc
echo ""
echo "##########################"
echo "# Setups microk8s config #"
echo "##########################"
echo ""
echo "Step 1/5: Going home"
cd $HOME
echo "Step 2/5: Create folder"
mkdir .kube
echo "Step 3/5: Go in new folder"
cd .kube
echo "Step 4/5: Export config"
sudo microk8s config > config
echo "Step 5/5: Go home"
cd $HOME
echo ""
echo "#########################"
echo "# Download kubeinvaders #"
echo "#########################"
echo ""
echo "Step 1/1: Add kubeinvaders repo"
sudo microk8s helm repo add kubeinvaders https://lucky-sideburn.github.io/helm-charts/
echo ""
echo "###########################"
echo "# Download Otel collector #"
echo "###########################"
echo ""
echo "Step 1/1: Adding otel collector"
sudo microk8s helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
echo ""
echo "################"
echo "# Update repos #"
echo "################"
echo "Step 1/1: Updating helm repos"
sudo microk8s helm repo update
echo ""
echo "#######################"
echo "# Setups kubeinvaders #"
echo "#######################"
echo ""
echo "Step 1/2: Creating namespace"
sudo microk8s kubectl create namespace kubeinvaders
echo "Step 2/2: Inalling kubeinvaders"
sudo microk8s helm install --set-string config.target_namespace="namespace1\,namespace2" --set ingress.enabled=true --set ingress.hostName=kubeinvaders.local --set deployment.image.tag=latest -n kubeinvaders kubeinvaders kubeinvaders/kubeinvaders --set ingress.tls_enabled=true
echo ""
echo "######################"
echo "# Python application #"
echo "######################"
echo ""
echo "Step 1/1: Install splunk-opentelemetry"
pip install splunk-opentelemetry[all]
echo "Step 1/2: Set the OTEL_SERVICE_NAME environment variable"
export OTEL_SERVICE_NAME=ajdService
echo ""
echo "######################"
echo "# Python application #"
echo "######################"
echo ""
echo "Step 1/1: Install java instrumentation."
curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent.jar -o splunk-otel-javaagent.jar
echo ""
echo "##########"
echo "# Reboot #"
echo "##########"
echo ""
echo "Step 1/1: Reboot"
sudo reboot