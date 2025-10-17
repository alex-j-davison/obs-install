# Overview

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

5.

<code> sudo microk8s helm install splunk-otel-collector --set="splunkObservability.accessToken=UkWiTCjeB_S0whQbIzNh2g,clusterName=SMEObs1,splunkObservability.realm=us1,gateway.enabled=false,splunkPlatform.endpoint=http://10.236.6.77:8088/services/collector/event,splunkPlatform.token=9609730b-994a-41a8-b72f-3b5d8d42e5c0,splunkObservability.profilingEnabled=true,environment=ajdSMEObs1Test,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector </code>

6.

<code> sudo microk8s kubectl patch deployment kubeinvaders -n kubeinvaders -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-python":"default/splunk-otel-collector"}}}}}' </code>
