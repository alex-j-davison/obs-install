# Obs install

## Scope of script

Script does the following:-

* Update OS
* Install microk8s 
* Creates alias
* Download kubeinvaders
* Download Otel collector
* Update repos
* Setups kubeinvaders 
* Setups microk8s config 

## Installation steps

Steps:-

1. Clone repo

<code>git clone https://github.com/alex-j-davison/obs-install.git</code>

2. Change permissions on shell scripts to execution

<code>chmod +x obs-install/setup.sh</code>

3. Run setup

<code>./obs-install/setup.sh | tee setupLog.log</code>

## Notes:- 

<code>https://github.com/alex-j-davison/obs-helm</code>

### Path application for APM

<code> sudo microk8s kubectl patch deployment kubeinvaders -n kubeinvaders -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}' </code>


### Forward port

<code> kubectl port-forward svc/kubeinvaders -n kubeinvaders 8080:80 --address='0.0.0.0'</code>

## Change log

### Version 1.0.0
