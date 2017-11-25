#!/bin/sh

echo "Running test entrypoint..."

bundle check || bundle install

bundle exec rake db:abort_if_pending_migrations 2>/dev/null || \
  bundle exec rake db:migrate 2>/dev/null || \
  bundle exec rake db:setup && bundle exec rake db:seed

bundle exec rspec spec || exit 1

if [ -n "$PULL_REQUEST_ID" ] && [ "$PULL_REQUEST_ID" != "false" ] && [ -n "$PRONTO_GITHUB_ACCESS_TOKEN" ]; then
    echo "Got an upstream PR #${PULL_REQUEST_ID}. Running pronto with github_pr reporter..."
    bundle exec pronto run -f github_pr
else
    echo "Got no PULL_REQUEST_ID or an insecure (fork) PR. Running pronto with default reporter..."
    bundle exec pronto run
fi
