#!/bin/bash

if [ "$1" = 'devpi' ]; then
    if [ ! -f  $DEVPISERVER_SERVERDIR/.serverversion ]; then
        if [ -z "${DEVPISERVER_PASSWORD}" ]; then
            echo "[ERROR]: DEVPISERVER_PASSWORD is not set. Use .env or another method to set the environment variable."
            exit 1
        fi
        echo "[RUN]: Initialise devpi-server"
        devpi-init --root-passwd="${DEVPISERVER_PASSWORD}" --serverdir="${DEVPISERVER_SERVERDIR}"
    fi
    echo "[RUN]: Launching devpi-server"
    devpi-server --restrict-modify root --host 0.0.0.0 --port 3141 --serverdir="${DEVPISERVER_SERVERDIR}"
fi
echo "[RUN]: Builtin command not provided [devpi]"
echo "[RUN]: $@"

exec "$@"
