#!/bin/sh

echo "Running main entrypoint..."

rake db:migrate 2>/dev/null || rake db:setup && rake db:seed

exec rails server --port 3000 --binding 0.0.0.0