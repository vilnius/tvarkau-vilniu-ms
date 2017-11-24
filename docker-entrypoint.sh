#!/bin/sh

echo "Running main entrypoint..."

rake db:abort_if_pending_migrations 2>/dev/null || rake db:migrate 2>/dev/null || rake db:setup && rake db:seed

[ -e /opt/tvarkau-vilniu/tmp/pids/server.pid ] && rm /opt/tvarkau-vilniu/tmp/pids/server.pid

exec rails server --port 3000 --binding 0.0.0.0
