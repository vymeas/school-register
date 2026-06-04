FROM node:20 AS node
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


FROM php:8.3-cli
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git curl unzip zip libzip-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

# 🔥 THIS IS THE MOST IMPORTANT LINE
RUN composer install --no-dev --optimize-autoloader --no-interaction

COPY --from=node /app/public/build /var/www/html/public/build

RUN chmod -R 777 storage bootstrap/cache
RUN mkdir -p storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache
RUN php artisan optimize:clear

CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t public"]