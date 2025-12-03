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
echo "Step 2/5: Create group"
sudo usermod -a -G microk8s $USER
echo "Step 3/5: Make directory"
sudo mkdir -p ~/.kube
echo "Step 4/5: Change permission on folder"
chmod 0700 ~/.kube
echo "Step 5/5: Enable features for microk8s"
sudo microk8s enable dns rbac hostpath-storage helm3
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
sudo mkdir .kube
echo "Step 3/5: Go in new folder"
cd .kube
echo "Step 4/5: Export config"
sudo microk8s config >> config
echo "Step 5/5: Go home"
cd $HOME
echo ""
echo "######################"
echo "# Download helm repo #"
echo "######################"
echo ""
echo "Step 1/3: Add kubeinvaders repo"
sudo microk8s helm repo add kubeinvaders https://lucky-sideburn.github.io/helm-charts/
echo "Step 2/3: Adding otel collector"
sudo microk8s helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
echo "Step 3/4: Updating helm repos"
sudo microk8s helm repo update
echo ""
echo "#######################"
echo "# Setups kubeinvaders #"
echo "#######################"
echo ""
echo "Step 1/2: Creating namespace"
sudo microk8s kubectl create namespace kubeinvaders
echo "Step 2/2: Installing kubeinvaders"
sudo microk8s helm install --set-string config.target_namespace="namespace1\,namespace2" --set ingress.enabled=true --set ingress.hostName=kubeinvaders.local --set deployment.image.tag=latest -n kubeinvaders kubeinvaders kubeinvaders/kubeinvaders --set ingress.tls_enabled=true
echo ""
echo "##################"
echo "# Install GitHub #"
echo "##################"
echo ""
echo "Step 1/1: Install github."
sudo snap install gh
echo ""
echo "################"
echo "# Setup GitHub #"
echo "################"
echo ""
echo "Step 1/3: Clone repo"
git clone https://github.com/alex-j-davison/obs-helm.git 
echo ""
echo "######################"
echo "# Setups Splunk Otel #"
echo "######################"
echo ""
echo "Step 1/3: Create splunkotel namespace"
sudo microk8s kubectl create ns otel
echo "Step 2/3: Install new config to namespace splunkotel"
sudo microk8s helm -n otel install splunk-otel-collector --values ./obs-helm/newinstall.yaml splunk-otel-collector-chart/splunk-otel-collector

total_seconds=15
while [ $total_seconds -gt 0 ]; do
    printf "Time remaining: %d seconds\r" "$total_seconds"
    sleep 1
    total_seconds=$((total_seconds - 1))
done

echo "Step 3/3: List pods in splunkotel"
sudo microk8s kubectl -n splunkotel get pods
echo ""