SHELL := /bin/bash
 
IMAGE_NAME ?= counter-strike-go
STEAM_ACCOUNT ?= 
STEAM_PASSWORD ?= 

.PHONY: all clean image run

all: image

clean:
	docker rmi $(IMAGE_NAME)

image: Dockerfile
	docker build -t $(IMAGE_NAME) \
        --build-arg steam_user=$(STEAM_ACCOUNT) \
        --build-arg steam_password=$(STEAM_PASSWORD) .

run:
	docker run \
		-d \
		-p 27016:27016/tcp \
		-p 27016:27016/udp \
		-p 27020:27020/udp \
		-p 27005:27005/udp \
		-e "SERVER_HOSTNAME=My host" \
		-e "SERVER_PASSWORD=" \
		-e "RCON_PASSWORD=" \
		-e "STEAM_ACCOUNT=$(STEAM_ACCOUNT)" \
		-e "PORT=27016" \
		--name counter_strike_go \
		$(IMAGE_NAME)
