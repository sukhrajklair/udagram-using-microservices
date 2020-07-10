# Use NodeJS base image
FROM node:13

#create app directory in docker
WORKDIR /usr/src/app

#copy dependency information
COPY ./udagram-feed-api/package*.json ./

#install dependencies in docker
RUN npm install

#copy app from local environment into docker
COPY ./udagram-feed-api/ ./
#build the app
RUN npm run build

#Set the API's port number
EXPOSE 8080

#define docker's behavior when image is run
CMD ["node","www/server.js"]
