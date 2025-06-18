Dockerfile
FROM php:8.2-cli

RUN apt-get update && apt-get install -y unzip zip git curl libzip-dev libpng-dev libonig-dev libxml2-dev && docker-php-ext-install zip pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN unzip minimal_laravel_uploadable.zip && \
    rm minimal_laravel_uploadable.zip && \
    cd minimal_laravel_uploadable && \
    composer install && \
    php artisan key:generate

EXPOSE 10000

CMD ["php", "minimal_laravel_uploadable/artisan", "serve", "--host=0.0.0.0", "--port=10000"]
