SERVER_IMAGE_NAME = sns-server
SERVER_IMAGE_LABEL = latest
SERVER_CONTAINER_NAME = sns-server


build-server:
	docker build \
		-f server/Dockerfile \
		-t $(SERVER_IMAGE_NAME):$(SERVER_IMAGE_LABEL) \
		.

run-server:
	$(eval RUNNING != docker inspect --format="{{.State.Running}}" --type container $(SERVER_CONTAINER_NAME) $^ 2>/dev/null ; true)
	if [ $(RUNNING) = "true" ]; then \
	  docker stop $(SERVER_CONTAINER_NAME) ; \
	fi
	docker run \
	  -d \
	  --name $(SERVER_CONTAINER_NAME) \
	  --rm \
	  $(SERVER_IMAGE_NAME):$(SERVER_IMAGE_LABEL)
