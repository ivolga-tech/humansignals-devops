# Verify Installation

In this section we check that some of the required steps have been
correctly installed and configured.

## TODO

After installation is done, go to the server where are HumanSignals
is deployed and run this command:

```sh
$ kubectl -n humansignals get all
```
You will see something like this:

![pods](images/kube_get_all.png)

Check that all pods are running or complete.
At the end of check that completions are done.

![completions](images/completions.png)

After it check your deployment from web browser.

If you do not have real hostname, you need to edit your `hosts` file.

```sh
$ sudo nano /etc/hosts
```

place at the end of file string in this format:

`IP hostname`

**Example**

![hosts](images/hosts.png)
