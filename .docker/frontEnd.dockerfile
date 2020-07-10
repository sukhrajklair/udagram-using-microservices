# Using base ionic image
FROM woahbase/alpine-ionic AS ionic
USER root
#create the application directory
#USER ionic
#RUN mkdir /usr/src/app
WORKDIR /usr/src/app

#install dependencies
COPY ./udagram-front-end/package*.json ./
RUN npm install

#copy app source
COPY ./udagram-front-end/ ./
RUN ionic build

#Use nginx server to serve the built files
FROM nginx:alpine
# Copy custom nginx config
COPY ./.docker/config/nginx.conf /etc/nginx/nginx.conf
#Copy files within Docker image from www folder to nginx folder
COPY --from=ionic /usr/src/app/www /usr/share/nginx/html
