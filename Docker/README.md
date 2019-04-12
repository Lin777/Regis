# Deploy with Docker

## Prerequisites

- Install a maintained version of Docker Community Edition (CE) or Enterprise Edition (EE) on a supported platform. [Install docker](https://docs.docker.com/install/).
- Download the [Docker](https://github.com/Lin777/ESUGConfRegistrationApp/tree/master/Docker) folder of this repo.

## Steps to follow

- Locate your terminal inside the docker folder that you recently downloaded.
- Run the following script to build the image with all the prerequisites from the Dockerfile file:
```bash
./buildDocker.sh
``` 
- Run the following script to create a container from the esug image:
```bash
./startDocker.sh
``` 
- Now you can see the page running in: http://localhost:8000/ESUG
- To stop the container
```bash
./stopDocker.sh
``` 

## Connect to a running container

- The above script will make you enter a container terminal, where you must execute the following script:
```bash
./bashDocker.sh
``` 
- Connect to the shell that ran pharo
```bash
screen -r esug
```
- To exit this bash, type Ctr + d

## Restore the data if the image breaks

The page generates a backup file after each modification to the database, to restore this data, follow the next steps:

- Connect to the container in which I create the image:
```bash
./bashDocker.sh
``` 
- Run the following script to re-create a fresh Pharo image:
```bash
./createPharoImage.sh
``` 
- And finally execute this command, to re-launch this fresh image:
```bash
screen -Sdm esug ./pharo esug.image --no-quit
``` 
