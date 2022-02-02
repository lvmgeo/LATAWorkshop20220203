# LATA workshop 2022.02.03 materials

## Requirements

- Docker (or Docker Desktop)
- QGIS 3.x
- PowerShell

### Structure

- `docker-compose.yml` - main compose file to be used in docker orchestrator. This docker file is extension of `compose-gs-template.yml` and `compose-pg-template.yml`
- `compose-gs-template.yml` - template of GeoServer portion of docker file. This file is used to specify parameters for GeoServer docker app.
- `compose-pg-template.yml` - only used by local docker desktop testing of environment. Specifies PostGIS DB image for local testing.
- `scripts\renewLVMRaodSHPFile.ps1` - sample script for downloading LVM Road data from LVM OpenData.
- `index.html` - demo HTML for using WMS with OpenLayers

### Usage

Modify `docker-compose.yml` in accordance with orchestrator, monitoring, backup solutions used and infrastructure deployment pipelines.

To run development environment
``` powershell
docker-compose -f "docker-compose.yml" up -d --build
```

### Main configuration consideration

See full documention [kartoza/geoserver](https://hub.docker.com/r/kartoza/geoserver/)

### Tomcat properties:

You can change the variables based on [GeoServer container considerations](https://docs.geoserver.org/stable/en/user/production/container.html). These arguments operate on the -Xms and -Xmx options of the Java Virtual Machine.

- INITIAL_MEMORY=<size> : Initial memory that Java can allocate, default 2G.
- MAXIMUM_MEMORY=<size> : Maximum memory that Java can allocate, default 4G.

### Control flow properties

The control flow module manages requests in GeoServer. Instructions on what each parameter mean can be read from the documentation.

- Example default values for the environment variables
  - REQUEST_TIMEOUT=60
  - PARARELL_REQUEST=100
  - GETMAP=10
  - REQUEST_EXCEL=4
  - SINGLE_USER=6
  - GWC_REQUEST=16
  - WPS_REQUEST=1000/d;30s
  -
**NB** You should customize these variables based on the resources available with your GeoServer.

### Docker secrets

To avoid passing sensitive information in environment variables, _FILE can be appended to some variables to read from files present in the container. This is particularly useful in conjunction with Docker secrets, as passwords can be loaded from /run/secrets/<secret_name> e.g.:

- -e GEOSERVER_ADMIN_PASSWORD_FILE=/run/secrets/

For more information see [https://docs.docker.com/engine/swarm/secrets/](https://docs.docker.com/engine/swarm/secrets/).

Currently, the following environment variables are supported.

- GEOSERVER_ADMIN_USER
- GEOSERVER_ADMIN_PASSWORD
- S3_USERNAME
- S3_PASSWORD
- TOMCAT_USER
- TOMCAT_PASS
- PKCS12_PASSWORD
- JKS_KEY_PASSWORD
- JKS_STORE_PASSWORD

## Technology stack

- Docker
- GeoServer 2.20.1 [kartoza/geoserver](https://hub.docker.com/r/kartoza/geoserver/) image used with the following stable plugins
  - vectortiles-plugin
  - wps-plugin
  - printing-plugin
  - libjpeg-turbo-plugin
  - control-flow-plugin
  - pyramid-plugin
  - gdal-plugin
  - monitor-plugin
  - inspire-plugin
  - csw-plugin
- Apache Tomcat 9.x
- PostgreSQL/PostGIS 13-3.2-alpine [postgis/postgis](https://hub.docker.com/r/postgis/postgis) image
