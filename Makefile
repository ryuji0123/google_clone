BACKEND_IMAGE_NAME = sns-backend
BACKEND_IMAGE_LABEL = latest
BACKEND_CONTAINER_NAME = sns-backend


build-backend:
	docker build \
		-f backend/Dockerfile \
		-t $(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_LABEL) \
		.

run-backend:
	$(eval RUNNING != docker inspect --format="{{.State.Running}}" --type container $(backend_CONTAINER_NAME) $^ 2>/dev/null ; true)
	if [ $(RUNNING) = "true" ]; then \
	  docker stop $(BACKEND_CONTAINER_NAME) ; \
	fi
	docker run \
	  -d \
	  --name $(BACKEND_CONTAINER_NAME) \
	  --rm \
	  $(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_LABEL)
