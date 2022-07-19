#!/bin/sh
#Markus Schaeffer <sizufly@gmail.com>

currentdir=${PWD##*/}
currentname=ribelle

help(){
	echo "Usage: $(basename $0) [-I arg] [-C arg] [-c arg] [-l] [-p] [-S]"
	echo " "
	echo "    -I create  create docker image."
	echo "    -I remove  remove docker image."
	echo "    -C create  create docker container."
	echo "    -C remove  remove docker container."
	echo "    -C start   start  docker container."
	echo "    -C stop    stop r docker container."
	echo "    -l         list docker containers."
	echo "    -c bash    exec bash into docker container."
	echo "    -c ssh     exec ssh root@localhost -p 2022 into container."
	echo "    -S         sweep docker image and docker container."
}

while getopts 'lSbc:C:I:h' opt; do
	case "$opt" in
		l)
			docker container ls
			;;

		S)
			docker rm -f $currentdir 
			docker image rm -f $currentname/$currentdir
			;;
		
		b)
			echo "Processing option 'b'"
			docker exec -it $currentdir bash
			;;

		c)
			arg="$OPTARG"
			if [ "$arg" = "bash" ]; then
				docker exec -it $currentdir bash
			elif [ "$arg" = "ssh" ]; then
				ssh root@localhost -p 2022
			fi
			;;
		
		I)
			arg="$OPTARG"
			if [ "$arg" = "create" ]; then
				docker build -t $currentname/$currentdir .
			elif [ "$arg" = "remove" ]; then
			 	docker image rm -f $currentname/$currentdir 
			fi
			;;
		
		C)
			arg="$OPTARG"
			if [ "$arg" = "create" ]; then
				#docker run -d -P --rm -ti --name $currentdir $currentname/$currentdir:latest
				docker run -d -P -p 2022:22 --rm -ti --name $currentdir $currentname/$currentdir:latest
			elif [ "$arg" = "remove" ]; then
				docker rm -f $currentdir 
			elif [ "$arg" = "start" ]; then
				docker start $currentdir
			elif [ "$arg" = "stop" ]; then
				docker stop $currentdir
			elif [ "$arg" = "ip" ]; then
				docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $currentdir
			fi
			;;
		
		?|h)
			help
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"
