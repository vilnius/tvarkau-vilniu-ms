#!/bin/sh

echo "Running test entrypoint..."

rake db:migrate 2>/dev/null || rake db:setup && rake db:test:prepare

bundle exec rspec spec

if [ -n "$PULL_REQUEST_ID" ] && [ "$PULL_REQUEST_ID" != "false" ] && [ -n "$PRONTO_GITHUB_ACCESS_TOKEN" ]; then
    echo "Got an upstream PR #${PULL_REQUEST_ID}. Running pronto with github_pr reporter..."
    pronto run -f github_pr
else
    echo "Got no PULL_REQUEST_ID or an insecure (fork) PR. Running pronto with default reporter..."
    pronto run
fi
