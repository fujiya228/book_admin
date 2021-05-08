#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}

echo $@

useradd -u $USER_ID -o -m public-user
groupmod -g $GROUP_ID public-user

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec /usr/sbin/gosu public-user "$@"
