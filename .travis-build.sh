#!/bin/bash 


# if [ "${TRAVIS_PULL_REQUEST_SHA}" == "" ] ; then
#     exit 0
# fi


if [ "${1}" == "1" ] ; then
    echo "BUILD TOOLS"
    git clone https://github.com/bmatusiak/arduino-1.6.5-r5-teensy_127 ./builder
    cd ./builder
    make get-master
    make docker-build-toolchain
elif [ "${1}" == "2" ] ; then
    cd ./builder
    make show-build #show results
elif [ "${1}" == "3" ] ; then
    if [ -d "./builder/OnlyKey-Firmware" ] ; then
        cd ./builder/builds/OnlyKey-Firmware
        echo $(git rev-parse --verify HEAD | cut -c1-7)
    else
        echo "ERROR" 
    fi
elif [ "${1}" == "9" ] ; then
    
    cd ./builder/OnlyKey-Firmware
    buildid=$(git rev-parse --verify HEAD | cut -c1-7)
    cd ../libraries
    echo $buildid-$(git rev-parse --verify HEAD | cut -c1-7)
    
elif [ "${1}" == "" ] ; then
    echo "BUILD"
    cd ./builder
    make docker-build-local
fi
   
