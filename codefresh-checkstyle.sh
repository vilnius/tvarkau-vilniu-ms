#!/bin/sh

git config --add remote.origin.fetch +refs/pull/*/head:refs/remotes/origin/pull/*
git fetch origin

export PULL_REQUEST_ID=`git branch -r --contains $CF_REVISION 2>/dev/null | sed -n 's/^.*pull\/\([0-9]\+\)$/\1/p'`

echo "PR REV $CF_REVISION"

if [ -z "$PULL_REQUEST_ID" ]; then
    echo "Got PULL_REQUEST_ID=${PULL_REQUEST_ID}, running pronto with github_pr reporter..."
    pronto run -f github_pr -c origin/master
else
    echo "Got no PULL_REQUEST_ID, running pronto with default reporter..."
    pronto run -c origin/master
fi
