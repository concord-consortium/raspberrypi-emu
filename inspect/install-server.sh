#!/bin/bash

#
# Install flow-server and rhizo-server to run in docker container
#
SERVER_DIR=inspect-server

if [ "$1" == "clean" ]; then
    rm -rf $SERVER_DIR
    exit 0
fi

mkdir -p $SERVER_DIR

cp templates/* $SERVER_DIR

cd $SERVER_DIR
git clone https://github.com/rhizolab/rhizo-server

cd rhizo-server
mkdir -p extensions
cd extensions
touch __init__.py
git clone https://github.com/manylabs/flow-server
cd ../../


