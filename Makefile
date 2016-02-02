#!/bin/make

build-images:
	docker build --file=Dockerfile.vidispine --tag=vidispine/webapp ./
	docker build --file=Dockerfile.postgres  --tag=vidispine/database ./

vidispine-db-fast:
	exists=$$( docker ps -a -q --filter="name=vidispine-database" | wc -l ); \
	if [ $$exists -eq 1 ]; then \
		docker kill vidispine-database; \
		docker rm vidispine-database; \
	fi;

	docker run \
		--name=vidispine-database \
		--detach=true \
		--dns=127.0.1.1 \
		--dns=8.8.8.8 \
		vidispine/database

vidispine-webapp-fast:
	exists=$$( docker ps -a -q --filter="name=vidispine-webapp" | wc -l ); \
	if [ $$exists -eq 1 ]; then \
		docker kill vidispine-webapp; \
		docker rm vidispine-webapp; \
	fi;

	docker run \
		--name=vidispine-webapp \
		--interactive \
		--tty \
		--link vidispine-database:vidispine-database \
		--publish 8000:8080 \
		--publish 8008:8088 \
		--publish 8009:8089 \
		--dns=127.0.1.1 \
		--dns=8.8.8.8 \
		vidispine/webapp

vidispine-fast: vidispine-db-fast vidispine-webapp-fast

vidispine: build-images vidispine-fast
