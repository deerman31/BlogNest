COMPOSE_FILE	:= ./srcs/docker-compose.yml
MKDIR_CMD		:= mkdir -p $(HOME)/data/sql $(HOME)/data/wordpress
RM_DATA_CMD		:= sudo rm -rf $(HOME)/data
RM_PS_CMD		:= docker rm -f $$(docker ps -qa)
RM_VOL_CMD		:= docker volume rm -f $$(docker volume ls)
RM_IMAGE_CMD	:= docker rmi -f $$(docker image ls -q)
RM_NETWORK_CMD	:= docker network rm $$(docker network ls -q)
START			:= docker compose -f $(COMPOSE_FILE) start
STOP			:= docker compose -f $(COMPOSE_FILE) stop
DOWN			:= docker compose -f $(COMPOSE_FILE) down
UP				:= docker compose -f $(COMPOSE_FILE) up --build -d
HOST_ADD		:= sudo sh tools/add.sh
HOST_DELETE		:= sudo sh tools/delete.sh

all:
	@$(MKDIR_CMD)
	@$(HOST_ADD)
	@$(UP)

restart:
	@$(STOP)
	@$(START)

down:
	@$(DOWN)

clean:
	-@$(RM_PS_CMD)
	-@$(RM_VOL_CMD)
	-@$(RM_IMAGE_CMD)
	-@$(RM_DATA_CMD)
	-@$(RM_NETWORK_CMD)
	-@$(HOST_DELETE)
	$(MAKE) down

re:
	make clean
	make all

status:
	@echo "---Listing all Docker containers---"
	@docker ps -a
	@echo "----------------------------------------------------------"
	@echo "\n---Listing all Docker images---"
	@docker images
	@echo "----------------------------------------------------------"
	@echo "\n---Listing all Docker volumes---"
	@docker volume ls
	@echo "----------------------------------------------------------"
	@echo "\n---Listing all Docker networks---"
	@docker network ls
	@echo "----------------------------------------------------------"

.PHONY: all clean restart down re status
