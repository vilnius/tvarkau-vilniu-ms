#!/bin/sh

echo "Running test entrypoint..."

rake db:migrate 2>/dev/null || rake db:setup && rake db:test:prepare

bundle exec rspec spec

printf "%d\n" ${#PRONTO_GITHUB_ACCESS_TOKEN}

if [ -n "$PULL_REQUEST_ID" ]; then
    echo "Got PULL_REQUEST_ID=${PULL_REQUEST_ID}, running pronto with github_pr reporter..."
    pronto run -f github_pr
else
    echo "Got no PULL_REQUEST_ID, running pronto with default reporter..."
    pronto run
fi
