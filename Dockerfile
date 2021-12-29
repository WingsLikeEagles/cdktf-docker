FROM node:17.3.0-buster-slim

WORKDIR /app

COPY bin/*.deb /app/bin/
RUN apt-get install -y --no-install-recommends /app/bin/*.deb && rm /app/bin/*.deb # Install Terraform and dependencies

RUN mkdir /app/build

RUN npm -production i -g cdktf-cli && npm prune --production
RUN npm -production i -g typescript && npm prune --production

RUN npm i --save-dev cdktf@0.7.0 && npm prune --production
RUN npm i --save-dev constructs@10.0.9 && npm prune --production
RUN npm i --save-dev @cdktf/provider-aws@2.0.13 && npm prune --production
RUN npm i --save-dev @types/node && npm prune --production

COPY cdktf.json /app/cdktf.json

COPY bin/python3/*.deb /app/bin/python3/
RUN apt-get install -y /app/bin/python3/*.deb && rm -rf /var/lib/apt/lists/* && rm -rf /app/bin/python3
RUN pip3 install --upgrade pip # Use pip to upgrade itself, the one in the Buster repo is too old
RUN pip3 install 'poetry>=1.0.0'

RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

COPY poetry.lock /app/poetry.lock
COPY pyproject.toml /app/pyproject.toml
