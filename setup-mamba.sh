#!/bin/bash

export CONDA_DIR=/opt/conda

cd /root
mkdir -p install
cd install
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-pypy3-Linux-x86_64.sh -O /tmp/mambaforge.sh
bash /tmp/mambaforge.sh -b -p $CONDA_DIR
rm /tmp/mambaforge.sh
echo "export CONDA_DIR=/opt/conda" >> ~/.bashrc
echo "export PATH=${CONDA_DIR}/bin:${PATH}" 
echo "source $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.bashrc