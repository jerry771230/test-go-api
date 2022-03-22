.PHONY: all remove run restart logs 

all:
	@echo $$ make remove
	@echo $$ make run
	@echo $$ make restart
	@echo $$ make logs
	@echo $$ make go_run
remove:
	@docker-compose down

run:
	@docker-compose up -d

restart:
	@docker-compose down && \
	docker-compose up -d

logs:
	@docker-compose logs -f

go_run:
	@docker exec -ti test-web go run /srv/internal/main.go

mod_vendor:
	@docker exec -ti test-web go mod vendor