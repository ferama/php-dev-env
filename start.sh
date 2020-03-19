#! /bin/bash
script_dir=$(dirname "$0")
root=$(cd $script_dir && pwd)

echo "userid=$(id -u):$(id -g)" > $root/.env

mkdir -p www

docker-compose build
# docker-compose stop www && docker-compose rm www
# docker-compose up