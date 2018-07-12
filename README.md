# DocDokuPLM docker-compose

This project aims to deploy a DocDokuPLM platform with docker-compose, for debugging and development only

## Installation

Requirements

* Docker
* Docker Compose

## platform-ctl

`platform-ctl` is a command wrapper that aims to ease build, deployment and starting/stopping the whole software stack.

Run `platform-ctl help` to list all commands

### Init and start the platform

First step is to clone the repositories and to create the base images. This may take a while, let's have a coffee break.

You can clone with ssh or https (default).

	./platform-ctl init-repo [ssh|https]
	./platform-ctl build-images

Then it's time to package some artifacts

    ./platform-ctl build-artifacts

Start the platform

	./platform-ctl up

Deploy the artifacts

	./platform-ctl deploy

Launch your browser once artifacts are all deployed

	./platform-ctl browser [dev|prod]

### Logging and monitoring

Get platform health

	./platofrm-ctl heatlh

List platform containers

	./platform-ctl status

Output logs from all containers

	./platform-ctl logs

### Build env commands

You can run any command in the build env with

	./platform-ctl run "<command>"

Example

	./platform-ctl run "mvn clean install -f /src/docdoku-plm"

Look at the `build-env/Dockerfile` for more details on the system

### SQL Management

You can create an admin account, or users accounts

	./platform-ctl create-user demo changeit
	./platform-ctl create-admin root supersecret

You can also directly connect to the sql instance

	./platform-ctl sql

You will be asked for your MySQL password (See `db/init.sql`)

### Stop the app

This will shut down all containers

	./platform-ctl down

### Development && Debugging

You can edit the sources in the `volumes/src` folder and work with git as usual. Run the command `git fetch --unshallow` on each repository to get the full history.

Use the remote debug feature from your IDE. Payara debug port is 19009.

Add to your remote target options `-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=19009`

### Notes

#### Docker-Compose

For more advanced commands, all `docker-compose` commands are supported. See https://docs.docker.com/compose/reference/ for full details

#### Platform-ctl

`platform-ctl` can be symlinked or added to your PATH

	(sudo) ln -s /path/to/platform-ctl /usr/bin/
