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
echo "Step 1:"
sudo apt-get update
echo ""
echo "################"
echo "# Install helm #"
echo "################"
echo ""
echo "Step 1:"
sudo snap install helm --classic
echo "Step 2:"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "Step 3:"
sudo apt-get install apt-transport-https --yes
echo "Step 4:"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
echo "Step 5:"
sudo apt-get install helm
echo ""
echo "################"
echo "# Create alias #"
echo "################"
echo ""
echo "Step 1:"
echo 'alias helm=microk8s.helm' | sudo tee -a  /etc/bash.bashrc
echo "Step 2:"
echo 'alias kubectl=microk8s.kubectl' | sudo tee -a  /etc/bash.bashrc
echo "Step 3:"
. /etc/bash.bashrc
echo ""
echo "#########################"
echo "# Download kubeinvaders #"
echo "#########################"
echo ""
echo "Step 1:"
helm repo add kubeinvaders https://lucky-sideburn.github.io/helm-charts/
echo "Step 2:"
helm repo update
echo ""
echo "###########################"
echo "# Download Otel collector #"
echo "###########################"
echo ""
echo "Step 1:"
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
echo "Step 2:"
helm repo update
echo ""
echo "####################"
echo "# Install microk8s #"
echo "####################"
echo ""
echo "Step 1:"
sudo snap install microk8s --classic --channel=1.25/stable
echo "Step 2:"
sudo microk8s enable dns 
echo "Step 3:"
sudo microk8s enable dashboard
echo "Step 4:"
sudo microk8s enable storage
echo "Step 5:"
sudo microk8s enable storage hostpath-storage rbac ingress
echo "Step 6:"
sudo microk8s inspect
echo ""
echo "######################"
echo "# Setup kubeinvaders #"
echo "######################"
echo ""
echo "Step 1:"
kubectl create namespace kubeinvaders
echo "Step 2:"
helm install --set-string config.target_namespace="namespace1\,namespace2" --set ingress.enabled=true --set ingress.hostName=kubeinvaders.local --set deployment.image.tag=latest -n kubeinvaders kubeinvaders kubeinvaders/kubeinvaders --set ingress.tls_enabled=true
echo ""
echo "#########################"
echo "# Setup microk8s config #"
echo "#########################"
echo ""
echo "Step 1:"
cd $HOME
echo "Step 2:"
mkdir .kube
echo "Step 3:"
cd .kube
echo "Step 4:"
microk8s config > config
echo "Step 5:"
newgrp microk8s
echo "Step 6:"
sudo usermod -a -G microk8s splunker
echo "Step 7:"
sudo chown -f -R splunker ~/.kube
echo "Step 8:"
cd
echo ""
echo "####################"
echo "# Validate install #"
echo "####################"
echo ""
echo "Step 1:"
sudo microk8s kubectl get all --all-namespaces
echo "########################"
echo "# Setup Otel collector #"
echo "########################"
echo ""
echo "Step 1:"
#helm install splunk-otel-collector --set="splunkObservability.accessToken=UkWiTCjeB_S0whQbIzNh2g,clusterName=SMEObs1,splunkObservability.realm=us1,gateway.enabled=false,splunkPlatform.endpoint=http://10.236.6.77:8088/services/collector/event,splunkPlatform.token=9609730b-994a-41a8-b72f-3b5d8d42e5c0,splunkObservability.profilingEnabled=true,environment=ajdSMEObs1Test,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector
echo "Example:-"
echo "helm install splunk-otel-collector --set="splunkObservability.accessToken=UkWiTCjeB_S0whQbIzNh2g,clusterName=SMEObs1,splunkObservability.realm=us1,gateway.enabled=false,splunkPlatform.endpoint=http://10.236.6.77:8088/services/collector/event,splunkPlatform.token=9609730b-994a-41a8-b72f-3b5d8d42e5c0,splunkObservability.profilingEnabled=true,environment=ajdSMEObs1Test,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector"
echo ""
#kubectl patch deployment <my-deployment> -n <my-namespace> -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}'
echo "Example:-"
echo "kubectl patch deployment <my-deployment> -n <my-namespace> -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}'"
echo ""