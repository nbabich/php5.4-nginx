DOCKER_IMAGE=dubzap/php5.4-fpm-nginx
CONTAINER_NAME=php
CONTAINER_BRANCH=dev
CONTAINER_VERSION=0.1
ARGUMENTS_BUILD=-t
ARGUMENTS_RUN=--restart=always --net host    -v /var/www:/var/www  -v /var/nginx:/etc/nginx -v /var/log/docker:/var/log  
APP_NAME=${CONTAINER_NAME}-${CONTAINER_BRANCH}-${CONTAINER_VERSION}
 
.PHONY: help
help:
	@echo "APP 	 	=> ${APP_NAME}"
	@echo "APP Name 	=> ${CONTAINER_NAME}"
	@echo "APP Branch 	=> ${CONTAINER_BRANCH}"
	@echo "APP Version 	=> ${CONTAINER_VERSION}"

# Сборка проекта
build:
	docker build -t ${DOCKER_IMAGE} .

# Статус всех контейнеров
ps:
	docker ps -a

# Статус всех images
img:
	docker images

# Развертывание всех контейнеров
run:
	docker run -d --name ${APP_NAME} ${ARGUMENTS_RUN} ${DOCKER_IMAGE} 

# Остановка и удаление всех контейнеров
stop:
	docker stop ${APP_NAME}

# Запуск php-fpm контейнера
bash:
	docker exec -it ${APP_NAME} /bin/bash
# Удаление контейнера
rm:
	docker rm ${APP_NAME}
# Удаление неиспользуемых образов
rm-img:
	docker image prune -a -f
#Рестарт
restart:
	docker restart ${APP_NAME}
#Логирование контейнера
log:
	docker logs ${APP_NAME}
inspect:
	docker inspect ${APP_NAME}
#Загрузка свежего образа
pull:
	docker pull dubzap/php5.4
#Пересборка контейнера
rerun:
	docker stop ${APP_NAME} && docker rm ${APP_NAME} &&  docker run -d --name ${APP_NAME} ${ARGUMENTS_RUN} ${DOCKER_IMAGE}
