# Obs install

## Description

Script does the following:-

* Update OS
* Get DNS values
* Install microk8s 
* Creates microk8s alias
* Setup microk8s configs
* Download Helm Repos (Update repos)
    * kubeinvaders
    * otel collector
* Setup pods:-
    * kubeinvaders
    * nginx
* Install github
* Clone helm repo
* Setup otel collector

## Installation steps

Steps:-

1. Clone repo

<code>git clone https://github.com/alex-j-davison/obs-install.git</code>

2. Change permissions on shell scripts to execution

<code>chmod +x obs-install/setup.sh</code>

3. Run setup

<code>./obs-install/setup.sh | tee setupLog.log</code>

4. Modify user

<code>sudo usermod -a -G microk8s splunker</code>

5. Change owner

<code>sudo chown -f -R splunker ~/.kube</code>

6. Create new group

<code>newgrp microk8s</code>

## Release

### Notes:-

### Version 2.0.0

* Update README
* Enable microk8s add-ons:-
    * ingress 
    * helm3
    * dashboard
    * storage
* Remove groups changes

### Version 1.0.0

* Initial setup

## User Guide  

### Start microk8s dashboard

<code>sudo microk8s dashboard-proxy</code>

### Create cluster 

https://microk8s.io/docs/clustering

<code>sudo microk8s add-node</code>

<code>vi /etc/hosts</code>

Add it

10.202.36.106 ip-10-202-36-106

10.202.34.204 ip-10-202-34-204

### Forward port

Forward UI port to local host

<code> kubectl port-forward svc/kubeinvaders -n kubeinvaders 8080:80 --address='0.0.0.0'</code>

## References:- 

### kubernetes

https://kubernetes.io/docs/home/

### microk8s

https://canonical.com/microk8s

### helm 
https://helm.sh/docs/helm/helm

### Helm Rep
https://github.com/alex-j-davison/obs-helm