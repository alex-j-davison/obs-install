# Instance type: m5/xlarge (vcpu 4 / 16 GiB ram)
# Operating System: Ubuntu 20.04
# Disk Storage 100 Gib SSD


echo "###############################################################"
echo "# Script: Step-2 Setup observability instance                 #"
echo "# Description: To create a observability instance.            #"
echo "# Created date: 19/09/25                                      #"
echo "# Arthur: Alex J Davison (alexdav@cisco.com)                  #"
echo "# Version: 0.0.1                                              #"
echo "# Starting...                                                 #"
echo "###############################################################"
echo ""
echo "##########################"
echo "# Setups microk8s config #"
echo "##########################"
echo ""
echo "Step 1/8: Going home"
cd $HOME
echo "Step 2/8: Create folder"
mkdir .kube
echo "Step 3/8: Go in new folder"
cd .kube
echo "Step 4/8: Add group to user"
sudo usermod -a -G microk8s splunker
echo "Step 5/8: Change folder ownership"
sudo chown -f -R splunker ~/.kube
echo "Step 6/8: Create new group"
sudo newgrp microk8s
echo "Step 7/8: Export config"
microk8s config > config
echo "Step 8/8: Go home"
cd $HOME
echo ""
echo "#########################"
echo "# Download kubeinvaders #"
echo "#########################"
echo ""
echo "Step 1/1: Add kubeinvaders repo"
helm repo add kubeinvaders https://lucky-sideburn.github.io/helm-charts/
echo ""
echo "###########################"
echo "# Download Otel collector #"
echo "###########################"
echo ""
echo "Step 1/1: Adding otel collector"
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
echo ""
echo "################"
echo "# Update repos #"
echo "################"
echo "Step 1/1: Updating helm repos"
helm repo update
echo ""
echo "#######################"
echo "# Setups kubeinvaders #"
echo "#######################"
echo ""
echo "Step 1/2: Creating namespace"
kubectl create namespace kubeinvaders
echo "Step 2/2: Inalling kubeinvaders"
helm install --set-string config.target_namespace="namespace1\,namespace2" --set ingress.enabled=true --set ingress.hostName=kubeinvaders.local --set deployment.image.tag=latest -n kubeinvaders kubeinvaders kubeinvaders/kubeinvaders --set ingress.tls_enabled=true
echo ""
echo "####################"
echo "# Validate install #"
echo "####################"
echo ""
echo "Step 1/2: Show all resources in microk8s"
sudo microk8s kubectl get all --all-namespaces
echo "Step 2/2: Helm repo list"
helm repo list
echo ""
echo "########################"
echo "# Setup Otel collector #"
echo "########################"
echo ""
echo "Step 1/1:"
echo "Example:-"
echo "helm install splunk-otel-collector --set="splunkObservability.accessToken=UkWiTCjeB_S0whQbIzNh2g,clusterName=SMEObs1,splunkObservability.realm=us1,gateway.enabled=false,splunkPlatform.endpoint=http://10.236.6.77:8088/services/collector/event,splunkPlatform.token=9609730b-994a-41a8-b72f-3b5d8d42e5c0,splunkObservability.profilingEnabled=true,environment=ajdSMEObs1Test,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector"
echo ""
#kubectl patch deployment <my-deployment> -n <my-namespace> -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}'
echo "Example:-"
echo "kubectl patch deployment <my-deployment> -n <my-namespace> -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}'"
echo ""