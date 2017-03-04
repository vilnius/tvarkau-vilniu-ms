#!/bin/sh

rake db:migrate 2>/dev/null || rake db:setup

bundle exec rspec spec
