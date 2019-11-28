#!/bin/bash

cd tools/codeDuplicationParser
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
cd ../..

chmod +x tools/Moss/moss