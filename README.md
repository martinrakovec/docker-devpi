# docker-devpi

This repository contains a Dockerfile for [devpi-server](http://doc.devpi.net/latest/).
The main purpose of this repository is to simplify the deployment and operation of devpi-server.

# Quickstart

This quickstart shows how to start devpi/server localy and use it as local pypi.org mirror.
There is a ton of things you can do with devpi.
See the [devpi documentation](https://devpi.net/docs/devpi/devpi/stable/+doc/index.html)
for details and how-tos.

## Start the server
Before you begin, copy .env.sample to .env and set environment variables in it.
Use [Docker Compose](https://docs.docker.com/compose/) to run server container.

```bash
docker compose up --build
```

Now, your own devpi-server should be running on http://localhost:3141.

NOTE: devpi-server data are preserved in the data directory which is mounted as volume.

## Use the server

By default, the server works as mirror of pypi.org. You can simply configure your local machine to use it

```bash
pip config set global.index-url http://localhost:3141/root/pypi/+simple
```
