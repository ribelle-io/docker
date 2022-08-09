#!/bin/sh
rm id_rsa.pub
ssh-keygen -t rsa -b 4096
cp ~/.ssh/id_rsa.pub .
