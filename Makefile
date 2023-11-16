#----------------------------------------------------------------------------------------------------------------------
# Flags
#----------------------------------------------------------------------------------------------------------------------
SHELL:=/bin/bash
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOCKER_IMAGE_NAME=ai_gstreamer_image

CUDA?=ON

DOCKER_RUN_PARAMS= \
	-it --rm -a stdout -a stderr --ipc=host \
	-e DISPLAY=${DISPLAY} -e NO_AT_BRIDGE=1 \
	-v ${CURRENT_DIR}:/workspace \
	-v /tmp/.X11-unix:/tmp/.X11-unix  -v ${HOME}/.Xauthority:/home/root/.Xauthority 
	


ifeq ($(CUDA),ON) 
	DOCKER_BASE_IMAGE =  nvcr.io/nvidia/deepstream_360d:5.0-20.08
	DOCKER_IMAGE_NAME := ${DOCKER_IMAGE_NAME}_nvidia
	DOCKER_RUN_PARAMS := ${DOCKER_RUN_PARAMS}  ${DOCKER_IMAGE_NAME}
else
	
endif


#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
default:  run
.PHONY:  

build:
	@$(call msg, Building Docker image ${DOCKER_IMAGE_NAME} ...)
	docker build --rm --build-arg BASE_IMAGE=${DOCKER_BASE_IMAGE} \
			.  -t ${DOCKER_IMAGE_NAME} 
	
run: build
	@$(call msg, Running the application ...)
	@xhost +
	@docker run ${DOCKER_RUN_PARAMS} bash 

#----------------------------------------------------------------------------------------------------------------------
# helper functions
#----------------------------------------------------------------------------------------------------------------------
define msg
	tput setaf 2 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo  "" && \
	echo "         "$1 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo "" && \
	tput sgr0
endef

