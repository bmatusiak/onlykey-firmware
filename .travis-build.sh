#!/bin/bash -xe


if [ "${1}" == "1" ] ; then
    echo "BUILD TOOLS"
    git clone https://github.com/bmatusiak/arduino-1.6.5-r5-teensy_127 ./builder
    cd ./builder
    make docker-build-toolchain
else
    if [ "${1}" == "2" ] ; then
        cd ./builder
        make show-build #show results
    else
        if [ "${1}" == "3" ] ; then
            cd ./builder/OnlyKey-Firmware
            echo $(git rev-parse --verify HEAD | cut -c1-7)
        else
            echo "BUILD"
            cd ./builder
            make docker-build
        fi
    fi
fi
