#!/bin/sh
currentdir=${PWD##*/}
currentname=sizufly
docker image rm -f $currentname/$currentdir 
