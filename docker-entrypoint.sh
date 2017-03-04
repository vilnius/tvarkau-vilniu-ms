#!/bin/sh

rake db:migrate 2>/dev/null || rake db:setup

exec rails server --port 3000 --binding 0.0.0.0
