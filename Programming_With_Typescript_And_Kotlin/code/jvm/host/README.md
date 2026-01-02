# Command line reference

## Build images

* `./gradlew buildImageJvm` - builds the JVM image with chimp backend HTTP API
* `./gradlew buildImagePostgresTest` - builds the Postgres image for testing
* `./gradlew buildImageUbuntu` - builds an image with Ubuntu and the DIG DNS tool
* `./gradlew buildImageNginx` - builds the Nginx image
* `./gradlew buildImageAll` - builds all images

## Start, scale, and stop services

* `./gradlew allUp` - starts all services.
* `./gradlew allDown` - stops all services.
* On the `host` folder, `docker compose up -d --scale chimp-jvm-dynamic=3` - scales the dynamic JVM service.

## Nginx

* `docker exec -ti chimp-nginx bash` - open shell on contained running Nginx.
* `nginx -s reload` - reloads Nginx configuration.

## Ubuntu

* `docker exec -ti ubuntu bash` - open shell on contained running Ubuntu.
* `dig chimp-jvm-dynamic` - uses `dig` to resolve the addresses for the `chimp-jvm-dynamic` hostname.


