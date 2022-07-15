#!/bin/sh
#Markus Schaeffer <sizufly@gmail.com>

currentdir=${PWD##*/}
currentname=sizufly

while getopts 'lsbc:i:h' opt; do
	case "$opt" in
		l)
			docker container ls
			;;

		s)
			docker rm -f $currentdir 
			docker image rm -f $currentname/$currentdir
			;;
		
		b)
			echo "Processing option 'b'"
			docker exec -it $currentdir bash
			;;
		
		i)
			arg="$OPTARG"
			if [ "$arg" = "create" ]; then
				docker build -t $currentname/$currentdir .
			elif [ "$arg" = "remove" ]; then
			 	docker image rm -f $currentname/$currentdir 
			fi
			;;
		
		c)
			arg="$OPTARG"
			if [ "$arg" = "create" ]; then
				docker run -d --rm -ti --name $currentdir $currentname/$currentdir:latest
			elif [ "$arg" = "remove" ]; then
				docker rm -f $currentdir 
			elif [ "$arg" = "start" ]; then
				docker start $currentdir
			elif [ "$arg" = "stop" ]; then
				docker stop $currentdir
			fi
			;;
		
		?|h)
			echo "Usage: $(basename $0) [-s] [-a] [-c arg] [i- arg]"
			echo " "
			echo "    -i create          create $currentname/$currentdir docker image."
			echo "    -i remove          remove $currentname/$currentdir docker image."
			echo "    -c create          create $currentdir docker container."
			echo "    -c remove          remove $currentdir docker container."
			echo "    -c start           start $currentdir docker container."
			echo "    -c stop            stop $currentdir docker container."
			echo "    -l                 list docker containers."
			echo "    -b                 start bash into $currentdir docker container."
			echo "    -s                 sweep docker image $currentname/$currentdir and docker container $currentdir."
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"
