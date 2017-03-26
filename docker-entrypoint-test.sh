#!/bin/sh

echo "Running test entrypoint..."

rake db:drop 2>/dev/null
rake db:setup

bundle exec rspec spec
