#!/bin/bash

cd laradock
docker-compose up -d nginx mysql phpmyadmin mailhog redis || exit -1
cd ..
