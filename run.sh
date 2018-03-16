#!/bin/bash
wget https://github.com/arminc/clair-scanner/releases/download/v5/clair-scanner_linux_amd64 --no-check-certificate
mv clair-scanner_linux_amd64 clair-scanner
chmod +x clair-scanner