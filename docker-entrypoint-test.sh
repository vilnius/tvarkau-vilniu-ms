#!/bin/sh

echo "Running test entrypoint..."

bundle check || bundle install

bundle exec rake db:migrate 2>/dev/null || (
  bundle exec rake db:create \
  && bundle exec rake db:structure:load \
  && bundle exec rake db:migrate
)

bundle exec rspec spec || exit 1

if [ -n "$PULL_REQUEST_ID" ] && [ "$PULL_REQUEST_ID" != "false" ] && [ -n "$PRONTO_GITHUB_ACCESS_TOKEN" ]; then
    echo "Got an upstream PR #${PULL_REQUEST_ID}. Running pronto with github_pr reporter..."
    bundle exec pronto run -f github_pr
else
    echo "Got no PULL_REQUEST_ID or an insecure (fork) PR. Running pronto with default reporter..."
    bundle exec pronto run
fi
