echo "##########################"
echo "# Setups microk8s config #"
echo "##########################"

cd .kube
echo "Step 4/5: Export config"
microk8s config > config
echo "Step 5/5: Go home"
cd $HOME
echo ""