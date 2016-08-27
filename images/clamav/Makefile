# Build ClamAV image
#
# Usage:
# 	make (container|push|push-latest)

all: push

TAG=0.99.2-r1
NAME=quay.io/instrumentisto/clamav

container:
	docker build -t $(NAME):latest ./

push: container
	docker tag $(NAME):latest $(NAME):$(TAG)
	docker push $(NAME):$(TAG)

push-latest: container
	docker push $(NAME):latest
