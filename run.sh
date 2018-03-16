#!/bin/bash
docker run --net=host -d --name db arminc/clair-db:2017-09-18
docker run --net=host --add-host postgres:127.0.0.1 -d --name clair --net=host arminc/clair-local-scan:v2.0.1
./clair-scanner nginx:1.11.6-alpine example-nginx.yaml http://127.0.0.1:6060 127.0.0.1