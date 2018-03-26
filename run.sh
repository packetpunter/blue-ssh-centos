#!/bin/bash
docker run -d -P -v $(PWD)/config:/app/code/config blue-ssh
docker ps
