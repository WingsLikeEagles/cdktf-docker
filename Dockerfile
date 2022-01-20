FROM node:17.3.0-buster-slim

WORKDIR /app

COPY bin/*.deb /app/bin/
RUN apt-get install -y --no-install-recommends /app/bin/*.deb && rm /app/bin/*.deb # Install Terraform and dependencies

RUN mkdir /app/build

RUN npm i --save-dev -g cdktf-cli typescript && npm prune --production

RUN npm i --save-dev cdktf@0.7.0 && npm prune --production
RUN npm i --save-dev constructs@10.0.9 && npm prune --production
RUN npm i --save-dev @cdktf/provider-aws@2.0.13 && npm prune --production
RUN npm i --save-dev @types/node && npm prune --production
COPY cdktf.json /app/cdktf.json

COPY bin/python3/*.deb bin/python3/*.whl bin/python3/poetry/*.whl /app/bin/python3/
RUN apt-get install -y /app/bin/python3/*.deb && rm -rf /var/lib/apt/lists/* && python3 -m pip install --upgrade /app/bin/python3/pip-21.3.1-py3-none-any.whl && python3 -m pip install /app/bin/python3/*.whl && rm -rf /app/bin/python3

RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

COPY poetry.lock /app/poetry.lock
COPY pyproject.toml /app/pyproject.toml

RUN mkdir /app/temp
WORKDIR /app/temp
