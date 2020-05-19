DROP DATABASE IF EXISTS `larahero`;
DROP DATABASE IF EXISTS `larahero_test`;

CREATE DATABASE IF NOT EXISTS `larahero` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `larahero_test` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `larahero`.`migrations` (
    `id` int unsigned not null auto_increment primary key,
    `migration` varchar(255) not null,
    `batch` int not null
) default character set utf8mb4 collate 'utf8mb4_unicode_ci';

CREATE TABLE IF NOT EXISTS `larahero_test`.`migrations` (
    `id` int unsigned not null auto_increment primary key,
    `migration` varchar(255) not null,
    `batch` int not null
) default character set utf8mb4 collate 'utf8mb4_unicode_ci';

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'default'@'%' IDENTIFIED WITH mysql_native_password BY 'secret';
