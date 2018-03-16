#!/bin/bash
git clone git@github.com:jgsqware/clairctl.git $GOPATH/src/github.com/jgsqware/clairctl
cd $GOPATH/src/github.com/jgsqware/clairctl
docker-compose up -d postgres