# Obs install

## Scope of script

Script does the following:-

* Update OS
* Install microk8s 
* Creates alias
* Download kubeinvaders ()
* Download Otel collector
* Update repos
* Setups kubeinvaders 
* Setups microk8s config 

## Installation steps

Steps:-

1. Clone repo

<code> git clone https://github.com/alex-j-davison/obs-install.git </code>

2. Change directory

<code> cd obs-install/ </code>

3. Change permissions on shell scripts to execution

<code> chmod +x setup.sh </code>

4. Run setup

<code> ./setup.sh </code>

5. Install helm

<code>https://github.com/alex-j-davison/obs-helm</code>

6. Path application for APM

<code> sudo microk8s kubectl patch deployment kubeinvaders -n kubeinvaders -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}' </code>

## Change log

### Version 1.0.0