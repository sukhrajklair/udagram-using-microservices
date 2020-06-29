# Use NodeJS base image
FROM node:13

#create app directory in docker
WORKDIR /usr/src/app

#copy dependency information
COPY package*.json ./

#install dependencies in docker
RUN npm install

#copy app from local environment into docker
COPY ./www/. ./

#Set the API's port number
EXPOSE 8080

#define docker's behavior when image is run
CMD ["node","server.js"]