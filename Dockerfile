FROM osrf/ros:noetic-desktop

RUN apt-get -y update 
RUN apt install software-properties-common curl gnupg lsb-release python3-pip mc wget curl featherpad dos2unix tmux -y
RUN add-apt-repository universe

RUN apt-get -y update && apt install figlet toilet -y

RUN apt-get -y update && apt install -y software-properties-common && add-apt-repository ppa:kisak/kisak-mesa && apt upgrade -y

# Install libfranka and franka_ros
RUN apt-get -y update && apt install build-essential cmake git libpoco-dev libeigen3-dev -y

ENV WORKSPACE=/root/ros_ws
ENV SHAREDIR=/root/share
RUN mkdir -p $WORKSPACE
RUN mkdir -p $WORKSPACE/src
RUN mkdir -p /root/libs

WORKDIR /root/libs

RUN git clone --recursive https://github.com/frankaemika/libfranka # only for panda
WORKDIR /root/libs/libfranka

RUN mkdir build
WORKDIR /root/libs/libfranka/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF ..
RUN cmake --build .
RUN cpack -G DEB
RUN dpkg -i libfranka*.deb

WORKDIR $WORKSPACE

COPY starttmux.sh /root/starttmux.sh
COPY bye.sh /root/bye.sh

COPY setup-franka.sh /root/setup-franka.sh
RUN /bin/bash -c "/root/setup-franka.sh"

COPY setup-mamba.sh /root/setup-mamba.sh
RUN /bin/bash -c "/root/setup-mamba.sh"

RUN echo "source /opt/ros/noetic/setup.sh" >> ~/.bashrc
RUN echo "source /root/ros_ws/devel/setup.sh" >> ~/.bashrc

CMD ["/root/starttmux.sh"]


