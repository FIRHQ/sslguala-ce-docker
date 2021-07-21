RAKE = docker-compose run app bundle exec rake
RUN = docker-compose run app
RUN_DB = docker-compose run postgres

include app.env
export

install:
	@touch app.env
	@$(RUN) bundle exec rails db:create
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails db:seed
install_ssl:
	@echo "[DEPRECATED] \"make install_ssl\": command was been deprecated. Now we use Caddy Server for automatically manage SSL."
update:
	@sh ./scripts/create-version
	@docker-compose pull
	@make secret
	@touch app.local.env
	@make restart
	@docker tag homeland/homeland:latest homeland/homeland:$$(date "+%Y%m%d%H%M%S")
restart:
	@sh ./scripts/restart-app
	@docker-compose stop web
	@docker-compose up -d web
	@docker-compose stop app_backup
start:
	@docker-compose up -d
status:
	@docker-compose ps
stop:
	@docker-compose stop caddy web app app_backup worker
stop-all:
	@docker-compose down
console:
	@$(RUN) bundle exec rails console
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi
backup:
	@echo "Backing up database..."
	@$(RUN_DB) pg_dump -d homeland -h postgresql -U postgres > postgres.sql