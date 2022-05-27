#!/bin/bash

cd source
VERSION=0.0.1-alpha
tar -czvf "../dist/${VERSION}.tar.gz" ./bin ./sh ./utilities ./nabt.bootstrapper.bash ./nabt.ini.bash