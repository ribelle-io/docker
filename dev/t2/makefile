CURRENTNAME = ribelle
CURRENTDIR = $(notdir $(shell pwd))

.PHONY: clean

all: container 

help:
	clear
	@echo "makefile:"
	@echo "  all          copy-key, create image and container"
	@echo "  container    create image and container"
	@echo "  image        create image"
	@echo "  start        start container"
	@echo "  stop         stop container"
	@echo "  clean        remove key, image and container"
	@echo "  cleanup      remove key, all images, all containers and clear cache"
	@echo "  bash         zoot bash login into container "
	@echo "  root         root bash login into container"
	@echo "  ssh          ssh into container"
	@echo "  create-key   ssh-keygen -t rsa -b 4096"
	@echo "  copy-key     cp ~/.ssh/id_rsa.pub ."
	@echo "  add-key      ssh-add --apple-use-keychain ~/.ssh/id_rsa"
	@echo "  hosts        clean ~/.ssh/known_hosts"
	@echo "  help         this screen"

create-key:
	ssh-keygen -t rsa -b 4096

hosts:
	rm -f ~/.ssh/known_hosts
	cp ~/.ssh/known_hosts_empty ~/.ssh/known_hosts

copy-key:
	cp ~/.ssh/id_rsa.pub .

add-key:
	ssh-add --apple-use-keychain ~/.ssh/id_rsa

image: copy-key
	docker build -t $(CURRENTNAME)/$(CURRENTDIR) .

container: image
	docker run -d -P -p 2022:22 --rm -ti --name $(CURRENTDIR) $(CURRENTNAME)/$(CURRENTDIR):latest

start:
	docker run -d -P -p 2022:22 --rm -ti --name $(CURRENTDIR) $(CURRENTNAME)/$(CURRENTDIR):latest

stop:
	docker stop $(CURRENTDIR)

cleanup:
	rm -f id_rsa.pub
	docker stop $(shell docker ps -a -q)
	docker system prune -a -f

bash:	
	docker exec -it $(CURRENTDIR) bash

root:	
	docker exec -it -u root $(CURRENTDIR) bash

ssh:
	ssh zoot@localhost -p 2022

clean:
	docker rm -f $(CURRENTDIR)
	docker image rm -f $(CURRENTNAME)/$(CURRENTDIR)
	rm -f id_rsa.pub
