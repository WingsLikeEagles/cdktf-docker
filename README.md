# cdktf-docker
Docker implmentation of CDKTF for Terraforming  

Initial credit goes to https://www.reddit.com/user/SnooPears9582/  
From his post at https://www.reddit.com/r/Terraform/comments/qqqe8r/executing_cdktf_from_within_a_container/  
  
```
Found a solution.

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

Standard alpine image with the dependencies installed. Executing is a matter or running docker run with the volume mounted , managed to get it to CI/CD pipeline with this given that docker is available in your CI/CD tool
```

# Build the container  
This requires a file in the current directory named cdktf.json and the Dockerfile both from this repo.
`docker build -t cdktf-docker .`  

# Run the container  
`docker run --rm --name cdktf -i cdktf-docker:latest cdktf convert --language python`  

# Pip something in to the container  
`cat my_super_awesome_stuff.tf | docker run --rm --name cdktf-docker -i cdktf-docker:latest cdktf convert --language python`  
  
  
