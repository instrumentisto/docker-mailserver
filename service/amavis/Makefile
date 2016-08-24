# Build AMaViS image
#
# Usage:
# 	make (container|push)

all: push

TAG=2.10.1-r4
NAME=quay.io/instrumentisto/amavis

container:
	docker build -t $(NAME):latest ./

push: container
	docker tag $(NAME):latest $(NAME):$(TAG)
	docker push $(NAME):$(TAG)

push-latest: container
	docker push $(NAME):latest
