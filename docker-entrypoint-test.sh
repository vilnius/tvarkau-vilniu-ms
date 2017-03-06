#!/bin/sh

rake db:migrate 2>/dev/null || rake db:setup && rake db:seed

bundle exec rspec spec
