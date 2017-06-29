# DocDokuPLM docker-compose

This project aims to deploy a DocDokuPLM platform with docker-compose, for debugging and development only

## Installation

### Requirements 

* Docker
* Docker Compose
* DocDokuPLM server sources or an EAR file
* DocDokuPLM web-front sources or build files

You may need to install additional software to build from the sources, particullary:

* JDK 8
* Maven
* NodeJs
* Git

### Build the base image
	
The first time can take a few minutes (system image build)

	docker build -t docdokuplm:payara back/payara

Prepare the folders before first launch

	mkdir -p {localdata/{db,vault},autodeploy/bundles}


Download and extract web-front files and edit the compose file if needed

	volumes:
	      - ../docdoku-web-front/app:/usr/share/nginx/html

Launch the platform

	docker-compose up -d

Copy the `docdoku-plm-ear.ear` file that you want to deploy in the `autodeploy` folder. 


### Deploy from the source code

Clone the source projects if not already done

	git clone git@github.com:docdoku/docdoku-plm.git ../docdoku-plm
	git clone git@github.com:docdoku/docdoku-web-front.git ../docdoku-web-front
	
You should have this structure

	$ ls ..
	docdoku-plm docdoku-plm-docker docdoku-web-front
	
Build the ear with maven and copy it in the autodeploy folder.

	mvn -f ../docdoku-plm/pom.xml clean install
	cp ../docdoku-plm/docdoku-server/docdoku-server-ear/target/docdoku-server-ear.ear autodeploy

## Stop server

	docker-compose down

## Debugging

Use the remote debug feature from your IDE. Debug port is 19009.

	-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=19009


