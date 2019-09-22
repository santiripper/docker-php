FROM circleci/php:7.3.9-cli-node-browsers

COPY config/php.ini /usr/local/etc/php/
RUN sudo apt update
RUN sudo apt upgrade -y
RUN sudo apt install -y libgeoip-dev geoip-bin geoip-database libfreetype6-dev libjpeg62-turbo-dev libssl-dev ffmpeg gifsicle pngcrush libjpeg-progs findimagedupes libpng-dev libcurl4-gnutls-dev libicu-dev libmcrypt4 libmcrypt-dev libxml2-dev libpq-dev

# MYSQL
RUN sudo wget http://repo.mysql.com/mysql-apt-config_0.8.10-1_all.deb && sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb
RUN sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 8C718D3B5072E1F5
RUN sudo apt update && sudo apt install mysql-client
RUN sudo ln -s /usr/bin/ffprobe /usr/local/bin/ffprobe && sudo ln -s /usr/bin/ffmpeg /usr/local/bin/ffmpeg
RUN sudo apt install -y apt-utils
RUN sudo mkdir -p /usr/share/man/man1 \
     && sudo mkdir -p /usr/share/man/man7
RUN sudo apt install -y postgresql-client
RUN sudo apt upgrade -y
##postgresql postgresql-contrib
RUN sudo docker-php-ext-install -j$(nproc) pdo_mysql mbstring curl exif iconv hash intl json mbstring pcntl pdo_pgsql simplexml xml zip bcmath
RUN sudo docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN sudo docker-php-ext-install -j$(nproc) gd
RUN sudo docker-php-ext-install -j$(nproc) sysvmsg
RUN sudo docker-php-ext-install -j$(nproc) sysvsem
RUN sudo docker-php-ext-install -j$(nproc) sysvshm
RUN sudo pecl install mongodb && sudo docker-php-ext-enable mongodb
RUN sudo pecl install geoip-beta && sudo docker-php-ext-enable geoip
RUN composer self-update
RUN composer global require "hirak/prestissimo:^0.3"
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN sudo npm install cross-env -g