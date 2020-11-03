#!/bin/bash

cd tools/codeDuplicationParser
pypy3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
cd ../..

chmod +x tools/Moss/moss
