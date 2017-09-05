FROM circleci/php:7.1.8-browsers

RUN sudo apt update && sudo apt install -y libssl-dev ffmpeg gifsicle pngcrush libjpeg-progs findimagedupes libpng-dev libcurl4-gnutls-dev libicu-dev libmcrypt4 libmcrypt-dev libxml2-dev libpq-dev
RUN sudo docker-php-ext-install pdo_mysql gd mbstring curl exif iconv hash intl json mbstring mcrypt pcntl pdo_pgsql simplexml xml zip
RUN sudo pecl install mongodb && sudo docker-php-ext-enable mongodb
RUN composer global require "hirak/prestissimo:^0.3"