#!/bin/bash
docker run --net=host -d --name db arminc/clair-db:2017-09-18
docker run --net=host --add-host postgres:127.0.0.1 -d --name clair --net=host arminc/clair-local-scan:v2.0.1
wget https://github.com/arminc/clair-scanner/releases/download/v5/clair-scanner_linux_amd64 --no-check-certificate
mv clair-scanner_linux_amd64 clair-scanner
chmod +x clair-scanner