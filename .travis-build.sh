#!/bin/bash 

if [ $TRAVIS_PULL_REQUEST_SHA == "" ] ; then
    exit 1
fi

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
            if [ -d "./builder/OnlyKey-Firmware" ] ; then
                cd ./builder/builds/OnlyKey-Firmware
                echo $(git rev-parse --verify HEAD | cut -c1-7)
            else
                echo "ERROR"
            fi
        else
            echo "BUILD"
            cd ./builder
            make docker-build
        fi
    fi
fi
