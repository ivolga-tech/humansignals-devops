# Troubleshooting

If something went wrong, this section covers
a number of steps you can take to debug issues.

## Check pods

You can use this command to check that all of our pods are running.
```sh
$ kubectl -n humansignals get pods
```

![pods](images/pods.png)

## Check logs

You can use this command to check the logs of our pods.

```sh
$ kubectl -n humansignals logs <pod_name> | less
```

The best way to start your research is with the web container,
which runs all database migrations
and gives you an error if any of them fail.
