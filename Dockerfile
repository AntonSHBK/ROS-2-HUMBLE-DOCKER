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

# set work directory
RUN mkdir /workspace
WORKDIR /workspace

# copy project
COPY . .

RUN echo "All done!"