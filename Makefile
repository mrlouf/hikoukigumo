launch:
	@COMPOSE_BAKE=true docker compose -f ./containers/docker-compose.yml up -d --build

re:
	$(MAKE) stop
	$(MAKE) clean
	$(MAKE) launch

stop:	# stops ALL containers running on the host, not just the ones in the compose file
	docker stop $$(docker ps -aq) && docker rm $$(docker ps -aq)

clean:
	docker compose -f ./containers/docker-compose.yml down --remove-orphans
	docker system prune -f --volumes
	@rm -f containers/.env
	@rm -rf containers/nginx/ssl

fclean:
	@read -p "Are you sure? This will take down the whole network and you will lose the database. [y/N]: " confirm && [ "$$confirm" = "y" ] || exit 1
	$(MAKE) stop
	docker compose -f ./containers/docker-compose.yml down --remove-orphans --rmi all --volumes
	docker volume prune -f
	docker network prune -f
	docker image prune -a -f

.PHONY:
	re stop clean fclean launch