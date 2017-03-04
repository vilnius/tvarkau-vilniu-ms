#!/bin/sh

docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app
