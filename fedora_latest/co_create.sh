#!/bin/sh
currentdir=${PWD##*/}
currentname=sizufly
docker run -d --rm -ti --name $currentdir $currentname/$currentdir:latest
