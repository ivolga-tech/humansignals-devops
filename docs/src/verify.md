# Verify Installation

In this section we check that some of the required steps have been
correctly installed and configured.

### Check pods

Go to the server where are HumanSignals is deployed and run this command:

```
$ kubectl -n humansignals get pods
```

You will see something like this:

![pods](images/pods.png)

All pods should be running or completed.

### Check jobs

```
$ kubectl -n humansignals get jobs
```

![jobs](images/jobs.png)


### Check ingress

Go to your web browser and enter your domain.

![ingress](images/ingress.png)

If you do not have real domain, you need to edit your `hosts` file:

```sh
$ echo "<VM_IP> <HS_DOMAIN>" | sudo tee -a /etc/hosts
```

![hosts](images/hosts.png)
