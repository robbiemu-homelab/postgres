# Makefile

.PHONY: up down build reset

up:
	docker-compose up --build -d

down:
	docker-compose down

image:
	docker build -t custom-postgres .

build: image
	docker-compose build

reset:
	docker-compose down --remove-orphans -v
	docker-compose up --build -d
