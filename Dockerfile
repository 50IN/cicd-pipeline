FROM node:16  # Use a more recent, multi-architecture image
WORKDIR /opt
ADD . /opt
RUN npm install

ENTRYPOINT npm run start
