docker:
	docker-compose -f deployment/development/docker/docker-compose.yml up --remove-orphans

file:
	docker-compose -f deployment/development/file/docker-compose.yml up --remove-orphans