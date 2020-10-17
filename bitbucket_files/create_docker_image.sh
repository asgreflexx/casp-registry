#!/usr/bin/env bash

sudo docker build -t lacribeiro11/casp-service-registry:latest .
docker push lacribeiro11/casp-service-registry:latest
