#!/bin/sh
currentdir=${PWD##*/}
currentname=sizufly
docker build -t $currentname/$currentdir .
