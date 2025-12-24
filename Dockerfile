FROM node:lts-alpine
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start
