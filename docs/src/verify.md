# Verify Installation

In this section we check that some of the required steps have been
correctly installed and configured.

## TODO

After instalation is done, go to the server where are Humansignals is deployed and run thic command:

```sh
$ kubectl -n humansignals get all
```
You will see somthing like this:

![pods](../images/kube_get_all.png)

Check that all pods are running or complete.
At the end of check that completions are done

![completions](../images/completions.png)

After it check your deployment from web browser.

if you dont have real hostname, you need to edit yor hosts file.

**in linux**

```sh
$ sudo nano /etc/hosts
```

**in windows**

open this file with administrator privileges 
```sh
C:\Windows\System32\drivers\etc
```


place at the end of file string in this format:

ip_adress hostname

**Example**

![hosts](../images/hosts.png)




