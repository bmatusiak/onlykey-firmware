

#!/bin/bash -xe




if [ "${1}" == "1" ] ; then
    echo "BUILD TOOLS"
    git clone https://github.com/bmatusiak/arduino-1.6.5-r5-teensy_127 ./builder
    cd ./builder
    make docker-build-toolchain
else
    echo "BUILD"
    cd ./builder
    make docker-build
fi
