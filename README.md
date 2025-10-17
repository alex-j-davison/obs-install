# Overview

## Scope of script

Script does the following:-

1. Update OS
2. Install microk8s 
3. Creates alias
4. Download kubeinvaders ()
5. Download Otel collector
6. Update repos
7. Setups kubeinvaders 
8. Setups microk8s config 

## Installation steps

Steps:-

1. Clone repo

<code> git clone https://github.com/alex-j-davison/obs-install.git </code>

2. Change directory

<code> cd obs-install/ </code>

3. Change permissions on shell scripts to execution

<code> chmod +x step1.sh </code>

<code> chmod +x step2.sh </code>

4. Run step1

<code> ./step1.sh </code>

5. Reboot (Automatic if script is completed)

6. Run step2

<code> ./step2.sh </code>