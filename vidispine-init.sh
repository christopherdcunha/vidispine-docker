#!/bin/bash -ex
# (More info available via `man bash`)
# -x      Print the command before running it.
# -e      Exit immediately if a command returns a non-zero status.

sed -i'' "s/jdbc:postgresql:\/\/localhost\/vidispine/jdbc:postgresql:\/\/vidispine-database\/vidispine/g" /etc/vidispine/server.yaml
vidispine db init
vidispine db check
vidispine server &

# Wait for the Vidispine API to start up, then initialize it.
sleep 40 && curl -X POST "http://localhost:8080/APIinit/"