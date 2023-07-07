#!/bin/bash

if ! command -v bc &> /dev/null
then
    echo "bc could not be found, installing..."
    sudo apt-get update && sudo apt-get install -y bc
fi
make clean
make
