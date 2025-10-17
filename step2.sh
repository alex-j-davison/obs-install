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
echo "############################"
echo "# Permissions for microk8s #"
echo "############################"
echo ""
echo "Step 1/3: Add group to user"
echo "Run:- sudo usermod -a -G microk8s splunker"
echo "Step 2/3: Change folder ownership"
echo "Run:- sudo chown -f -R splunker ~/.kube"
echo "Step 3/3: Create new group"
echo "Run:- sudo newgrp microk8s"
