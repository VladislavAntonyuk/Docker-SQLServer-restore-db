# Docker Image for Database

- [Docker Image for Database](#docker-image-for-database)
  - [Prerequisites](#prerequisites)
  - [Create a local image](#create-a-local-image)
  - [Restore data](#restore-data)
    - [Exporting a bacpac manually](#exporting-a-bacpac-manually)
  - [Starting the container manually](#starting-the-container-manually)
  - [Something went wrong?](#something-went-wrong)

## Prerequisites

Firstly you'll need to have [Docker](https://www.docker.com/get-started/) installed on your machine. [See the official docs](https://docs.docker.com/) for more information on Docker itself.

## Create a local image

This needs to be done once:

```
$ cd .\docker\
$ docker-compose build
```

## Restore data

A bacpac file can be used to restore a copy of the database.

### Exporting a bacpac manually

Export the DB under "Tasks" > "Export Data-tier Application" and name the exported bacpac file "schema".

Place the `schema.bacpac` file into this folder and run:

```
$ docker-compose up
```

The container mounts the `schema.bacpac` and automatically restores the database.

The database will listen to `127.0.0.1:1433` on your host machine.

## Starting the container manually

If the above docker-compose doesn't work then you can also start the container using just the docker CLI:

```
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Password_123" -p 1433:1433 --name sql --hostname sql -d mcr.microsoft.com/mssql/server:2019-latest
```

As above, this will also start the database on your host machine at `127.0.0.1:1433`.

You will need to restore the database with the `schema.bacpac` file using a SQL IDE like SQL Server Management Studio. Name the database `db`.

## Something went wrong?

Kill the docker-compose using CTRL+C or use another terminal window to run

```
$ docker-compose rm -sf && docker-compose up
```

This will erase the existing database and reinitialise it from schema.bacpac# Docker-SQLServer-restore-db
