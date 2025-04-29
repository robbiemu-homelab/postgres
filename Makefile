# Makefile

.PHONY: up down build reset

up:
	docker-compose up --build -d

down:
	docker-compose down -v

image:
	docker build -t custom-postgres .

build: image
	docker-compose build

reset:
	docker-compose down -v
	docker-compose up --build -d
