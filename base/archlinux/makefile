CURRENTNAME = ribelle
CURRENTDIR = $(notdir $(shell pwd))

.PHONY: clean

all: container 

create-key:
	ssh-keygen -t rsa -b 4096

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
