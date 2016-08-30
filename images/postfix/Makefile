# Build Postfix image
#
# Usage:
# 	make [VERSION=...] [TAGS=t1,t2,...] (container|push|push-tags)

defaut: container


NAME=quay.io/instrumentisto/postfix
ifndef VERSION
  VERSION = 3.1.1-r0
endif
ifndef TAGS
  TAGS = latest
endif

comma:= ,
empty:=
space:= $(empty) $(empty)
tags := $(subst $(comma), $(space), $(TAGS))

container:
	docker build -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)
