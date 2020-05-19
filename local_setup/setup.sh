#!/bin/bash

echo "* Copy project .env file"
cp .env.example .env



echo "* Check the possibility whether the script could be executed"
appEnv=$(grep APP_ENV .env | xargs)
if [ $appEnv == "APP_ENV=production" ];then
   echo "==> Skip: this script is not allowed to run in production environment."
   exit -1
fi



echo "* Run composer to install dependencies"
composer install --prefer-dist -vvv || exit -1



echo "* Install laradock"
if [[ ! -d "laradock" ]]; then
    rm -rf laradock
    git clone https://github.com/Laradock/laradock.git
fi



echo "* Copy laradock .env file and override configuration"
cd laradock

# Because latest Laradock version has an error, checkout to working commit
git checkout a2c7b467662706ba1af118048baeaf6e27f6a74d
cp ./../local_setup/env-example .env
rm ./../laradock/mysql/my.cnf
cp ./../local_setup/mysql/my.cnf ./../laradock/mysql
docker-compose build --no-cache mysql



echo "* Up docker with docker-compose"
docker-compose kill
docker-compose up -d nginx mysql phpmyadmin mailhog

if [ $? -eq 0 ]; then
    echo " ==> Docker is up and running"
else
  sudo sh -c ''
  kill $(sudo lsof -t -i:80)
  sudo sh -c ''
  kill $(sudo lsof -t -i:3306)
  echo " ==> Re-run command up dokcer"
  docker-compose up -d nginx mysql phpmyadmin mailhog redis || exit -1
fi



echo "* Generate application key and create storage link"
docker-compose run --rm workspace php artisan key:generate


rm "./../public/storage"
docker-compose run --rm workspace php artisan storage:link



echo "* Create databases"
docker-compose run --rm mysql mysql -hmysql -uroot -proot < ./../local_setup/mysql_command.sql



echo "* Migrate tables and test data"
docker-compose run --rm workspace php artisan migrate --seed



echo "* Add host to /etc/hosts"
hostname="local.studyoffice.host test-local.studyoffice.host"
count=$(grep -o "$hostname" /etc/hosts | wc -l)
if [ $count != 0 ];then
   echo "==> Skip: host already existed."
else
  sudo sh -c ''
  echo "0.0.0.0 ${hostname}" >> /etc/hosts
  echo "::1     ${hostname}" >> /etc/hosts
fi



echo "* Compile resources"
cd ..
npm install
npm run dev



echo "*** DONE ***"
