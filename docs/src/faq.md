# Frequently Asked Questions

- [Are the errors I'm seeing important?](#are-the-errors-im-seeing-important)
- [How do I see logs for a pod?](#how-do-i-see-logs-for-a-pod)
- [How do I connect to the web server's shell?](#how-do-i-connect-to-the-web-servers-shell)
- [How do I connect to PostgreSQL?](#how-do-i-connect-to-postgresql)
- [How do I connect to ClickHouse?](#how-do-i-connect-to-clickhouse)
- [How do I restart all pods for a service?](#how-do-i-restart-all-pods-for-a-service)

## Are the errors I'm seeing important?

Here are some examples of log spam that currently exists
in our app and is safe to ignore:

The following messages in the ClickHouse pod happen when ClickHouse reshuffles
how it consumes from the topics. So, anytime ClickHouse or Kafka restarts
we'll get a bit of noise and the following log entries are safe to ignore:

```
<Error> TCPHandler: Code: 60, e.displayText() = DB::Exception: Table humansignals.sharded_events doesn't exist.
...
<Warning> StorageKafka (kafka_session_recording_events): Can't get assignment. It can be caused by some issue with consumer group (not enough partitions?). Will keep trying.
```

The following error is produced by some low-priority celery tasks and
we haven't seen any actual impact so can safely be ignored.

```
TooManyConnections: too many connections
  File "humansignals/celery.py",
  ...
  File "clickhouse_pool/pool.py", line 102, in pull
    raise TooManyConnections("too many connections")
```

## How do I see logs for a pod?

1. Find the name of the pod you want to get logs on:

```sh
$ kubectl -n humansignals get pods
```

This command will list all running pods. If you want app/plugin server logs,
for example, look for a pod that has a name starting with `humansignals-plugins`.
This will be something like `humansignals-plugins-b7759745d-kwb7b`.

2. Get the logs for that pod using the name from the previous step:

```sh
$ kubectl -n humansignals logs humansignals-plugins-b7759745d-kwb7b
```

## How do I connect to the web server's shell?

HumanSignals is built on Django, which comes with some useful utilities.
One of them is a Python shell. You can connect to it like so:

```sh
$ kubectl -n humansignals exec -it deploy/humansignals-web -c humansignals-web -- python manage.py shell_plus
```

In a moment you should see the shell load
and finally a message like this appear:

```
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>>
```

That means you can now type Python code and run it with
HumanSignals context (such as models) already loaded!

For example, to see the number of users in your instance run:

```python
User.objects.count()
```

## How do I connect to PostgreSQL?

1. Find out your PostgreSQL password from the web pod:

```sh
$ kubectl -n humansignals exec -it deploy/humansignals-web -c humansignals-web -- sh -c 'echo The PostgreSQL password is: $POSTHOG_DB_PASSWORD'
```

2. Connect to the `humansignals` database:

**You're connecting to your production database, proceed with caution!**

```sh
$ kubectl -n humansignals exec -it sts/humansignals-humansignals-postgresql -- psql -d humansignals -U postgres
```

PostgreSQL will ask you for the password.
Use the value you found out in step 1.

Now you can run SQL queries!
Just remember that an SQL query needs
to be terminated with a semicolon `;` to run.

## How do I connect to ClickHouse?

1. Find out your ClickHouse user and password from the web pod:

```sh
$ kubectl -n humansignals exec -it deploy/humansignals-web -c humansignals-web -- sh -c 'echo -e "User: $CLICKHOUSE_USER\nPassword: $CLICKHOUSE_PASSWORD"'
```

2. Connect to the `humansignals` database:

**You're connecting to your production database, proceed with caution!**

```sh
$ kubectl -n humansignals exec -it sts/chi-humansignals-humansignals-0-0 -- clickhouse-client -d humansignals --user <user_from_step_1> --password <password_from_step_1>
```

## How do I restart all pods for a service?

**Important**: Not all services can be safely restarted this way.
It is safe to do this for the app/plugin server.
If you have any doubts, ask someone from the HumanSignals team.

1. Terminate all running pods for the service:

```sh
$ kubectl -n humansignals scale --replicas 0 deploy/humansignals-plugins
```

2. Start new pods for the service:

```sh
$ kubectl -n humansignals scale --replicas 1 deploy/humansignals-plugins
```
