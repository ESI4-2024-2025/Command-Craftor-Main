# Command Craftor

## Introduction

Command Craftor is a web application designed to write Minecraft commands for the user.
It is based on two javascript apps :
- The [back](./back) uses nodejs express to handle requests and interacts with the database.
- The [front](./front) uses the data from the back and the user to automatically write the commands needed.
Here, we will only talk about how to install the project on your computer so you can test your updates locally.

## Installation

### Prerequisites

First, you will need to install the following :
- [Docker](https://docs.docker.com/engine/install/)
- Make (optional, should be automatically installed on ubuntu computers)

### Installation and Launch

Now to install your project.
First, you will need to add a .env file that you will be given when you start working on the project into each directory.

Second, you will use the following command:
```shell
make install
```
This will build the docker images needed to run the project locally, then run the containers and give you the link to test your app.

Alternatively, you can use this :
```shell
docker compose up -d --remove-orphans --build
docker exec command-craftor-main-front-1 npm install
docker exec command-craftor-main-back-1 npm install
```
This will build the images, remove previous orphaned containers, and run new ones based on the new images without making you enter them.

## Other commands

There are a few commands you can run on this project using make: 
- `make build`: builds the images, equivalent to `docker build front && docker build back`
- `make start`: starts the containers, equivalent to `docker compose up -d --remove-orphans`
- `make stop`: stops the containers, equivalent to `docker compose down`
- `make restart`: stops the containers and restarts them, equivalent to `docker compose up -d --remove-orphans && docker compose down`
- `make bash-front` or `make bash-back`: launches a shell cli into the container, equivalent to `docker exec command-craftor-main-<env>-1 /bin/sh`

Some can be useful depending on the situation.

## Conclusion

Now that you know all there is to know, have fun !