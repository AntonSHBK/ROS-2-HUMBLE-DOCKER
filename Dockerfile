FROM osrf/ros:humble-desktop-full

RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

RUN echo "All done!"