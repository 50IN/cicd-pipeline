FROM node:16-alpine
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start
