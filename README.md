# Udagram Image Application

Udagram is a simple cloud application developed alongside the Udacity Cloud Engineering Nanodegree. It allows users to register and log into a web client, post photos to the feed. This project refactored the app to be deployed as microservices using Kubernetes. The previous version of the app used a monolith architecture.

![application architecture](angular-docker-k8s.png)

## Architecture
The application has been divided into three service:
1. Front-end: an nginx server that serves static files for the front-end as well act as a reverse proxy for the backend services
2. Feed Backend: implements REST API for user feed. Communicates with postgresql database and S3 filestore to respond to the requests
3. User Backend: implements REST API for user management and login sessions. Uses JWT for authentication. Also communicates with the postgresql database to manage users.

## Containerization
The services have accompanying dockerfiles inside .docker directory to create docker images for them. A docker-compose.yaml file has also been created to automate docker image creation of all the service. Use following command to create docker images of all services locally:
```docker-compose build```
To push these images to your remote docker registry:
```docker-compose push```

## Deployment using Kubernetes
The project has also been setup to be deployed on AWS using Kubernetes. All of the required manifests have been created in .k8s directory. The kubernetes deployment is made up of following components:
1. Back-end feed api deployment and internal service for it
2. Back-end user api deployment and internal service for it
3. Front-end + reverse proxy nginx server deployment and an external service to expose to internet
4. Ingress controller + ingress resource to load balance the incoming traffic

Once you have created a k8s cluster using AWS EKS service and setup the local k8s tools to communicate with the cluster, 
1. create k8s secrets to pass the sensitive information to the application:
    simply run the createSecrets.sh script inside the .k8s directory. All of the secret variables should already be present in your local dev environment. The pod deployment files are already created to pass these secrets as environment variables to the containers inside the pods.
2. issue the following commands from the project directory to deploy the whole application:
    ```kubectl apply -f .k8s```