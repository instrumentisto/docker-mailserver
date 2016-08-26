# Build Dovecot image
#
# Usage:
# 	make (container|push|push-latest)

all: push

TAG=2.2.24-r1
NAME=quay.io/instrumentisto/dovecot

container:
	docker build -t $(NAME):latest ./

push: container
	docker tag $(NAME):latest $(NAME):$(TAG)
	docker push $(NAME):$(TAG)

push-latest: container
	docker push $(NAME):latest
