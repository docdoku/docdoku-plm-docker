# DocDokuPLM docker-compose

This project aims to deploy a DocDokuPLM platform with docker-compose, for debugging and development only

## Installation

Requirements

* Docker
* Docker Compose

## platform-ctl

`platform-ctl` is a command wrapper that aims to ease build, deployment and starting/stopping the whole software stack.

Run `platform-ctl help` to list all commands

First step is to clone the repositories and to create the base images. This may take a while, let's have a coffee break.

	./platform-ctrl init-repo
	./platform-ctrl build-images

Then it's time to package some artifacts

    ./platform-ctrl build-artifacts

Start the platform

	./platform-ctrl up

Deploy the artifacts

	./platform-ctrl deploy

List platform containers

	./platform-ctrl status

Get platform health

	./platofrm-ctl heatlh

For more advanced commands, all `docker-compose` commands are supported. See https://docs.docker.com/compose/reference/ for full details

## Logging

Output logs from all containers

	./platform-ctl logs

## Stop the app

This will shut down all containers

	./platform-ctl down

## Debugging

Use the remote debug feature from your IDE. Debug port is 19009.

Add to your remote target options `-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=19009`

## Notes

`platform-ctl` can be symlinked or added to your PATH