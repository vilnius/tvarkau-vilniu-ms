#!/bin/sh

docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml run --rm app; EXIT_STATUS=$?
docker-compose -f docker-compose.test.yml down

exit $EXIT_STATUS
