# DocDokuPLM Docker

Easy setup for DocDokuPLM with docker-compose.

## Prerequisites

* [Docker](https://docs.docker.com/get-docker/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Set vm.max_map_count to at least 262144](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_set_vm_max_map_count_to_at_least_262144)

## Start DocDokuPLM:

Clone or [download](https://github.com/docdoku/docdoku-plm-docker/archive/master.zip) this repository.

```
$ git clone https://github.com/docdoku/docdoku-plm-docker.git
$ cd docdoku-plm-docker
```

Open a terminal and run

```
$ ./start.sh
```

You can now verify that all containers are up

```
$ docker-compose ps
```

Then you can access to http://localhost:8000 from your web browser

## Port mapping

```
--------------------------
Port    Service
--------------------------
8000    docdoku-plm-front
8001    docdoku-plm-server
8002    kibana
8003    mailhog
8004    adminer
--------------------------
```

## Running in production

Make sure to edit all passwords in env files before you start the script.

