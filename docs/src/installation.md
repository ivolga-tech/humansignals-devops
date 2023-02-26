# Installation

## Download this repository using Git

```sh
$ git clone https://github.com/ivolga-tech/humansignals-devops.git
$ cd humansignals-devops/ansible
```

## Create a hosts file with your data

Use this command to create a hosts file with your credentails
such as destination IP and user with sudo privileges.

```sh
$ VM_IP=<destination IP> VM_USER=<sudo user> envsubst < hosts.example > hosts
```

## Set your domain

1. Open the `group_vars/humansignals.yml`
2. Change the `server.host` value

## Install dependencies

```sh
$ ansible-galaxy install -r requirements.yml
```

## TLS configuration

If you want to use selfsigned certificate:
1. Open the `group_vars/humansignals.yml`
2. Change the `server.production` value to `false`

In another case, when `server.production` value is `true` the certificate for your host will be generated automatically

## Clickhouse configuration

If you want to use external clickhouse cluster:
1. Open the `group_vars/humansignals.yml`
2. Change the `clickhouse.internalClickhouse` value to `false` and change values below

Clickhouse version must be >=21.6.0 <22.4.0. Humansignals may not work correctly with the another version. To continue anyway set `clickhouse.versionRequirements` variable to `false`

## Install dependencies

```sh
$ ansible-galaxy install -r requirements.yml
```

## Run Ansible Playbook

```sh
$ ansible-playbook -i hosts main.yml
```

Now you have to wait ~30 minutes.

## Check your HumanSignals installation

1. Open the web browser
3. Enter your domain or use the [default](https://humansignals-sda.ivolga.tech)
2. Congratulations! 🎉🎉🎉
