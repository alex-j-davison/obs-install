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

## Release

### Notes:-

### Version 2.0.0

* 

### Version 1.0.0

* Initial setup

## User Guide  

### Start dashboard
sudo microk8s dashboard-proxy

## Create cluster https://microk8s.io/docs/clustering
sudo microk8s add-node

vi /etc/hosts

Add it

10.202.36.106 ip-10-202-36-106

10.202.34.204 ip-10-202-34-204

## References:- 

https://helm.sh/docs/helm/helm

### Helm Rep
<code>https://github.com/alex-j-davison/obs-helm</code>