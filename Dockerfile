ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt update -y --allow-insecure-repositories

RUN apt install -y python3-pip build-essential libqt5widgets5
RUN apt install -y git

WORKDIR /workspace/

RUN git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps


