FROM osrf/ros:humble-desktop-full

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

# install dependencies
COPY requirements/common.txt /tmp/common.txt
COPY requirements/development.txt /tmp/development.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/development.txt

# set work directoryFROM osrf/ros:humble-desktop-full

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# set work directory
RUN mkdir /app
WORKDIR /app

# copy project
COPY . .

# Set shell conole and install some requirements 
SHELL [ "/bin/bash" , "-c" ]
RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

# Additional commands (installing dependencies)
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /workspace/dependencies.sh
RUN chmod +x /workspace/dependencies.sh

# install dependencies
COPY requirements/common.txt /tmp/common.txt
COPY requirements/developmet.txt /tmp/development.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/development.txt

RUN echo "All done!"
RUN mkdir /app
WORKDIR /app

# copy project
COPY . .

RUN echo "All done!"