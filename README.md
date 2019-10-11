# Instructions

The filebeat service listens to a single docker container on your host machine for logs to STDOUT. To enable it to fetch those logs, edit `docker-entrypoint.sh`, and set `TRACKED_CONTAINER` to the name of the container from which you want to harvest logs.

_Note: The container being harvested must be running before filebeat._

Once the `docker-entrypoint.sh` is up-to-date, simply start all services:
```sh
docker-compose up -d
```

Give it some time, and Kibana should eventually be available on `localhost:5601`.
