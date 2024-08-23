docker:
	docker-compose -f development/docker/docker-compose.yml up --remove-orphans

file:
	docker-compose -f development/file/docker-compose.yml up --remove-orphans