.PHONY: all remove run restart logs go_run mod_vendor docker.build docker.run docker.remove docker.logs

all:
	@echo $$ make remove
	@echo $$ make run
	@echo $$ make restart
	@echo $$ make logs
	@echo $$ make go_run
	@echo $$ make mod_vendor
	@echo $$ make docker.build
	@echo $$ make docker.run
	@echo $$ make docker.remove
	@echo $$ make docker.logs
remove:
	@docker-compose down

run:
	@docker-compose up -d

restart:
	@docker-compose down && \
	docker-compose up -d

logs:
	@docker-compose logs -f web

go_run:
	@docker exec -ti test-web go run /srv/internal/main.go

mod_vendor:
	@docker exec -ti test-web go mod vendor

docker.build:
	@docker build --rm -t go-test-web .

docker.run:
	@docker run -d --rm --name test-web -p 8089:8089 go-test-web

docker.remove:
	@docker rm -f test-web

docker.logs:
	@docker logs -f test-web