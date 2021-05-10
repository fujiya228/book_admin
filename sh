#!/bin/bash
LOCAL_UID=$(id -u $USER)
LOCAL_GID=$(id -g $USER)
base='docker-compose run --rm -e $LOCAL_UID -e $LOCAL_GID web'
exec $base $*

# setup
# ./sh rails new . --force --no-deps --database=mysql --skip-test --webpacker
# docker-compose build
# config/database.ymlを更新
# ./sh rake db:create
# docker-compose up