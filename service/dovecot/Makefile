# Build Dovecot image
#
# Usage:
# 	make (container|push)

all: push

TAG=2.2.24-r1
NAME=quay.io/instrumentisto/dovecot

container:
	docker build -t $(NAME):$(TAG) ./

push: container
	docker push $(NAME):$(TAG)
