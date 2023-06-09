#!/bin/bash

docker run \
  --rm \
  -e DISPLAY \
  -e XAUTHORITY=/tmp/.Xauthority \
  -v ~/.Xauthority:/tmp/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v `pwd`/share:/root/share \
  -p 9090:9090 \
  -p 8765:8765 \
  -p 5000:5000 \
  --expose=5000 \
  --expose=9090 \
  -it ros-noetic-panda 
