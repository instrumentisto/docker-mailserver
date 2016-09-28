# Build smf-spf image
#
# Usage:
# 	make [VERSION=] [TAGS=t1,t2,...] (container|push|push-tags)
# 	make [GCC_VER=] [SMFSPF_VER=] smf-spf

defaut: container


NAME = quay.io/instrumentisto/smf-spf
VERSION ?= 2.1.1_c0.0
TAGS ?= 2,2.1,2.1.1,latest

comma:= ,
empty:=
space:= $(empty) $(empty)
tags := $(subst $(comma), $(space), $(TAGS))

container: smf-spf
	docker build -t $(NAME):latest ./

container-nocache: clean smf-spf
	docker build --no-cache -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)


GCC_VER ?= latest
SMFSPF_VER ?= 2.1.1

smf-spf:
	rm -rf ./tmp/smf-spf
	mkdir -p ./tmp/smf-spf
	cp ./build-smf-spf.sh ./tmp/smf-spf/
	docker run --rm -it \
		-v $(PWD)/tmp/smf-spf:/out \
		-e SMFSPF_VER=$(SMFSPF_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-smf-spf.sh
	cp -rf ./tmp/smf-spf/result/* ./rootfs/


clean:
	rm -rf ./tmp ./rootfs/usr
