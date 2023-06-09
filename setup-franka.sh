#!/bin/bash

cd /root/ros_ws
mkdir -p src
source /opt/ros/noetic/setup.sh                                                                  
catkin_init_workspace src                                                                        
git clone --recursive https://github.com/frankaemika/franka_ros src/franka_ros         
rosdep install --from-paths src --ignore-src --rosdistro noetic -y --skip-keys libfranka
catkin_make -DCMAKE_BUILD_TYPE=Release -DFranka_DIR:PATH=/root/libs/libfranka
source devel/setup.sh
