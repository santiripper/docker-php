FROM circleci/php:7.1.8-browsers

COPY config/php.ini /usr/local/etc/php/
RUN sudo apt update && sudo apt install -y libfreetype6-dev libjpeg62-turbo-dev libssl-dev ffmpeg gifsicle pngcrush libjpeg-progs findimagedupes libpng-dev libcurl4-gnutls-dev libicu-dev libmcrypt4 libmcrypt-dev libxml2-dev libpq-dev
RUN sudo ln -s /usr/bin/ffprobe /usr/local/bin/ffprobe && sudo ln -s /usr/bin/ffmpeg /usr/local/bin/ffmpeg
RUN sudo docker-php-ext-install -j$(nproc) pdo_mysql mbstring curl exif iconv hash intl json mbstring mcrypt pcntl pdo_pgsql simplexml xml zip
RUN sudo docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN sudo docker-php-ext-install -j$(nproc) gd
RUN sudo pecl install mongodb && sudo docker-php-ext-enable mongodb
RUN composer global require "hirak/prestissimo:^0.3"