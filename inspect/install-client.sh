#!/bin/bash -e

#
# Install dependencies
#
sudo apt-get update
sudo apt-get install -y libjpeg-dev
sudo apt-get install -y python-dev
sudo apt-get install -y python-pip
sudo pip install gevent
sudo pip install ws4py
sudo pip install hjson
sudo pip install python-dateutil

#
# Install rhizo:
#
sudo apt-get install -y git-core
git clone git://github.com/rhizolab/rhizo

echo "export PYTHONPATH=/home/pi/rhizo" >> .bashrc

source .bashrc

#
# Install flow
#
git clone git://github.com/manylabs/flow
cd flow
sudo pip install --upgrade pip
sudo pip install image

#
# Start flow
#
# python flow.py   

