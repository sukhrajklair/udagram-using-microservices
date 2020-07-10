#!/bin/bash

#delete existing secrets
kubectl delete secrets --all

source ~/.profile

#database secrets
kubectl create secret generic database-config --from-literal=POSTGRES_USERNAME=$POSTGRES_USERNAME \
 --from-literal=POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
 --from-literal=POSTGRES_DATABASE=$POSTGRES_DATABASE \
 --from-literal=POSTGRES_HOST=$POSTGRES_HOST 

#aws secrets
kubectl create secret generic aws-config --from-literal=AWS_REGION=$AWS_REGION \
 --from-literal=AWS_PROFILE=$AWS_PROFILE \
 --from-literal=AWS_MEDIA_BUCKET=$AWS_MEDIA_BUCKET

#app secrets
kubectl create secret generic app-secrets --from-literal=JWT_SECRET=$JWT_SECRET \
 --from-literal=URL=$URL