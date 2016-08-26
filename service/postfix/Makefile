# Build Postfix image
#
# Usage:
# 	make (container|push)

all: push

TAG=3.1.1-r0
NAME=quay.io/instrumentisto/postfix

container:
	docker build -t $(NAME):latest ./

push: container
	docker tag $(NAME):latest $(NAME):$(TAG)
	docker push $(NAME):$(TAG)

push-latest: container
	docker push $(NAME):latest
