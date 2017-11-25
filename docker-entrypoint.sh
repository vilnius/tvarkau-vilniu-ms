#!/bin/sh

echo "Running main entrypoint..."

bundle check || bundle install

bundle exec rake db:migrate 2>/dev/null \
  || bundle exec rake db:create \
  && bundle exec rake db:structure:load \
  && bundle exec rake db:migrate \
  && bundle exec rake db:seed

[ -e /opt/tvarkau-vilniu/tmp/pids/server.pid ] && rm /opt/tvarkau-vilniu/tmp/pids/server.pid

bundle exec rails server --port 3000 --binding 0.0.0.0
