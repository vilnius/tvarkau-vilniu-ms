#!/bin/sh

docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml run --rm app
docker-compose -f docker-compose.test.yml down
