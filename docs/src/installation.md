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

## Run Ansible Playbook

```sh
$ ansible-playbook -i hosts main.yml
```

Now you have to wait ~30 minutes.

## Check your HumanSignals installation

1. Open the web browser
3. Enter your domain or use the [default](https://humansignals-sda.ivolga.tech)
2. Congratulations! 🎉🎉🎉
