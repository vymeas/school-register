FROM node:20 AS node

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


FROM php:8.3-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    git curl unzip zip libzip-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=node /app /var/www