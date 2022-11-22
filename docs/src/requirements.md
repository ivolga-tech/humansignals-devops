# Requirements

* You have deployed a Linux Debian/Ubuntu Virtual Machine.
    * An instance with 4 vCPU and 8GB of RAM can handle approximately 100k events spread over a month
    * We highly recommend an instance with at least 6 vCPU and 12GB of RAM to handle any surges in event volume
    * You will also need at least 100 GB of SSD disk
* You have set up a user on Virtual Machine.
    * The user must have sudo privileges without a password
* You have set up an A record to connect a custom domain to your instance.
    * HumanSignals will automatically create an TLS certificate for your domain using LetsEncrypt
* You have installed on your PC.
    * Git
    * Ansible
