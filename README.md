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

## DockerInstallation

### Linux 

#### Docker ce

Download and install from .deb file or from your repository (apt-get install docker-ce)

https://download.docker.com/linux/

#### Docker compose

Install docker-compose if not installed

Download the latest release from https://github.com/docker/compose/releases/

Make it executable and create a symlink or copy it to /usr/local/bin/

Add your user to docker group. Run as root:

	# usermod -aG docker your_user_name
	# gpasswd -a your_user_name docker

Start the service as root:

	# service docker start

Check if install is OK. Run as user:

	$ docker ps


### MacOSX

Download and open the docker-ce .dmg file from official site. Or browser https://download.docker.com/mac/

Run 

	$ open Docker

Or use the application search bar and type Docker

### Windows

TODO ...

## SSL

For local development, you need to trust the self signed certificates.

Copy the certificates from the container to your host

    docker cp docdoku-plm-docker_proxy:/etc/nginx/ssl/rootCA.pem /host/path/to/certs/
    docker cp docdoku-plm-docker_proxy:/etc/nginx/ssl/cert.crt /host/path/to/certs/

### Osx

Open keychain access and import both pem and key file. Double click on each and set "trust always".

### Ubuntu

Using ca-certificates

Run as root

	apt-get install ca-certificates
	cp /host/path/to/certs/* /usr/share/ca-certificates/
    update-ca-certificates


### Others ...

TODO ...