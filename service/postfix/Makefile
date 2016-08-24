# Build Postfix image
#
# Usage:
# 	make (container|push)

all: push

TAG=3.1.1-r0
NAME=quay.io/instrumentisto/postfix

container:
	docker build -t $(NAME):$(TAG) ./

push: container
	docker push $(NAME):$(TAG)
