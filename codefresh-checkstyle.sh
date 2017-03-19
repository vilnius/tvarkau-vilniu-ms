#!/bin/sh

git config --add remote.origin.fetch +refs/pull/*/head:refs/remotes/origin/pull/*
git fetch origin

export PULL_REQUEST_ID=`git branch -r --contains $CF_REVISION 2>/dev/null | sed -n 's/^.*pull\/\([0-9]\+\)$/\1/p'`

echo "PR ID $PULL_REQUEST_ID"
echo "PR REV $CF_REVISION"

if [ -z "$PULL_REQUEST_ID" ]; then
    pronto run -f github_status github_pr
else
    pronto run -c origin/master
fi
