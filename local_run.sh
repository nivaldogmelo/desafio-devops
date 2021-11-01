#!/usr/bin/env sh

./dockerize.sh

cd deploy/docker-compose/ && docker-compose up
