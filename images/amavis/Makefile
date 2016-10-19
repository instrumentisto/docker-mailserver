# Build AMaViS image
#
# Usage:
# 	make (container|push|push-tags) [VERSION=...] [TAGS=t1,t2,...] [no-cache=(yes|no)]
# 	make all [VERSION=...] [TAGS=tag1,tag2,...] [no-cache=(yes|no)]
# 	make (ripole|lrzip|freeze|nomarch|zoo)
# 	make clean

default: container


NAME := quay.io/instrumentisto/amavis
VERSION ?= 2.10.1_c0.1
TAGS ?= 2,2.10,2.10.1,latest
no-cache ?= no

comma:= ,
empty:=
space:= $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

tags = $(subst $(comma), $(space), $(TAGS))

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))


container: ripole lrzip freeze nomarch zoo
	docker build $(no-cache-arg) -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)


all: | clean container push push-tags

.PHONY: container push push-tags all


GCC_VER = latest
RIPOLE_VER = 0.2.0
LRZIP_VER = 0.630
FREEZE_VER = 2.5.0-16
NOMARCH_VER = 1.4
ZOO_VER = 2.10-27

ripole:
	rm -rf ./tmp/ripole
	mkdir -p ./tmp/ripole
	cp ./build-ripole.sh ./tmp/ripole/
	docker run --rm -it \
		-v $(PWD)/tmp/ripole:/out \
		-e RIPOLE_VER=$(RIPOLE_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-ripole.sh
	cp -rf ./tmp/ripole/result/* ./rootfs/

lrzip:
	rm -rf ./tmp/lrzip
	mkdir -p ./tmp/lrzip
	cp ./build-lrzip.sh ./tmp/lrzip/
	docker run --rm -it \
		-v $(PWD)/tmp/lrzip:/out \
		-e LRZIP_VER=$(LRZIP_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-lrzip.sh
	cp -rf ./tmp/lrzip/result/* ./rootfs/

freeze:
	rm -rf ./tmp/freeze
	mkdir -p ./tmp/freeze
	cp ./build-freeze.sh ./freeze-alpine-putc.patch ./tmp/freeze/
	docker run --rm -it \
		-v $(PWD)/tmp/freeze:/out \
		-e FREEZE_VER=$(FREEZE_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-freeze.sh
	cp -rf ./tmp/freeze/result/* ./rootfs/

nomarch:
	rm -rf ./tmp/nomarch
	mkdir -p ./tmp/nomarch
	cp ./build-nomarch.sh ./tmp/nomarch/
	docker run --rm -it \
		-v $(PWD)/tmp/nomarch:/out \
		-e NOMARCH_VER=$(NOMARCH_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-nomarch.sh
	cp -rf ./tmp/nomarch/result/* ./rootfs/

zoo:
	rm -rf ./tmp/zoo
	mkdir -p ./tmp/zoo
	cp ./build-zoo.sh ./tmp/zoo/
	docker run --rm -it \
		-v $(PWD)/tmp/zoo:/out \
		-e ZOO_VER=$(ZOO_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-zoo.sh
	cp -rf ./tmp/zoo/result/* ./rootfs/


clean:
	rm -rf ./tmp ./rootfs/usr


.PHONY: ripole lrzip freeze nomarch zoo clean
