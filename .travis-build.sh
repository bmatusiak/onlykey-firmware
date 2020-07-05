#!/bin/bash 


if [ "${1}" == "0" ] ; then
    
    echo "TRAVIS_BRANCH=$TRAVIS_BRANCH TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"
    if [ $TRAVIS_PULL_REQUEST == "1" ] ; then
      curl https://peaceful-escarpment-81979.herokuapp.com/build/travis-ci/build
    fi
    
fi

if [ $TRAVIS_PULL_REQUEST == "1" ] ; then
  exit 0
fi


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
    buildid=$(git rev-parse --verify HEAD)
    cd ../libraries
    echo $buildid-$(git rev-parse --verify HEAD)
    
elif [ "${1}" == "" ] ; then
    echo "BUILD"
    cd ./builder
    make docker-build-local
fi
  