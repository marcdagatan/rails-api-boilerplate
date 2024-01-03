#!/bin/bash

set -ex

if [$RAILS_ENV != 'development'] && [$RAILS_ENV != 'test']; then
  echo "** Installing / re-installing production bundle **"
  bundle config set --local deployment "true"
fi

bundle check || bundle install --jobs=3 --retry=3

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"