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

### Version 1.0.0

* Initial setup

## References:- 

<code>https://github.com/alex-j-davison/obs-helm</code>