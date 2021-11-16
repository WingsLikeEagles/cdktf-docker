FROM node:17-alpine3.14

RUN apk update && apk add terraform
RUN npm install -g cdktf-cli
RUN npm install -g typescript

RUN mkdir /app
RUN mkdir /app/build

WORKDIR /app

RUN npm i --save-dev cdktf@0.7.0
RUN npm i --save-dev constructs@10.0.9
RUN npm i --save-dev @cdktf/provider-aws@2.0.13
RUN npm i --save-dev @types/node

COPY cdktf.json /app/cdktf.json
