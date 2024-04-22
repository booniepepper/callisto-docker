arch := $(shell uname -m)
tag = booniepepper/callisto:latest

.PHONY: build
build:
	docker buildx build --no-cache -t=$(tag) . >build.log

.PHONY: test
test: build
	docker run $(tag) /bin/sh -c 'cac -i /opt/callisto/std /opt/callisto/examples/sierpinski.cal -o ./triforce && ./triforce'

.PHONY: release
release: build test
	docker push $(tag)
