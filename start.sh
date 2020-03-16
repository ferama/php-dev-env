#! /bin/bash
script_dir=$(dirname "$0")
root=$(cd $script_dir && pwd)

echo "userid=$(id -u)" > $root/.env

mkdir -p www

docker-compose build
docker-compose up