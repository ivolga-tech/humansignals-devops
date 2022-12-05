# Installation

## Download this repository using Git

```sh
$ git clone https://github.com/ivolga-tech/humansignals-devops.git
$ cd humansignals-devops/ansible
```

## Create a hosts file with your data

```sh
$ cat << EOF > hosts
[humansignals]
<VM_IP> ansible_user=<VM_USER>
EOF
```

## Install dependencies

```sh
$ ansible-galaxy install -r requirements.yml
```

## Run Ansible Playbook

```sh
$ ansible-playbook -i hosts main.yml
```

Now you have to wait ~30 minutes.
