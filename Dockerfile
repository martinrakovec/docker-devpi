FROM python:3.13

ARG ARG_DEVPI_SERVER_VERSION=6.13.0
ARG ARG_DEVPI_WEB_VERSION=4.2.3
ARG ARG_DEVPI_CLIENT_VERSION=7.1.0

ENV DEVPI_SERVER_VERSION=$ARG_DEVPI_SERVER_VERSION
ENV DEVPI_WEB_VERSION=$ARG_DEVPI_WEB_VERSION
ENV DEVPI_CLIENT_VERSION=$ARG_DEVPI_CLIENT_VERSION
ENV PIP_NO_CACHE_DIR="off"
ENV PIP_INDEX_URL="https://pypi.python.org/simple"
ENV PIP_TRUSTED_HOST="127.0.0.1"
ENV VIRTUAL_ENV="/venv"
ENV HOME=/data
ENV DEVPISERVER_SERVERDIR=${HOME}/server
ENV DEVPICLIENT_CLIENTDIR=${HOME}/client

# devpi user
RUN addgroup --system --gid 1000 devpi \
    && adduser --disabled-password --system --uid 1000 --home ${HOME} --shell /sbin/nologin --gid 1000 devpi \
    # create a virtual env in $VIRTUAL_ENV
    && echo "Creating virtual env in ${VIRTUAL_ENV}" \
    && python -m venv ${VIRTUAL_ENV} \
    && ${VIRTUAL_ENV}/bin/python -m pip install --upgrade pip wheel \
    # Install devpi packages sorted alphanumerically
    && ${VIRTUAL_ENV}/bin/pip install \
      "devpi-client==${DEVPI_CLIENT_VERSION}" \
      "devpi-server==${DEVPI_SERVER_VERSION}" \
      "devpi-web==${DEVPI_WEB_VERSION}"

ENV PATH=${VIRTUAL_ENV}/bin:$PATH

EXPOSE 3141
VOLUME ${HOME}

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER devpi
WORKDIR ${HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "devpi" ]
