#!/bin/bash

cd tools/codeDuplicationParser
pypy3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
cd ../..

chmod +x tools/Moss/moss

# Export environment variables
export OXYGEN_MIN_NODE_WEIGHT=30
export CHLORINE_MIN_NODE_WEIGHT=30
export CHLORINE_MIN_MATCH_COEFFICIENT=0.85
