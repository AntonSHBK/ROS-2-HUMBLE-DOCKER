FROM osrf/ros:humble-desktop-full

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

# Set shell console and install some requirements 
SHELL [ "/bin/bash" , "-c" ]

RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

# Additional commands (installing dependencies)
# RUN apt-get install -y ros-humble-turtlesim
# RUN apt-get install -y ros-humble-gazebo-ros
# RUN apt-get install -y ros-humble-gazebo-plugins

# install dependencies for pythom if you need
COPY requirements/common.txt /tmp/common.txt
COPY requirements/developmet.txt /tmp/development.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/development.txt

# added ros source
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

RUN echo "All done!"