FROM node:0.12.3-slim
MAINTAINER LintCI

### Setup User ###
ENV user lint_trap
ENV group linters
ENV homedir /src/

RUN mkdir -p $homedir \
 && groupadd -r $group -g 777 \
 && useradd -u 666 -r -g $group -d $homedir -s /sbin/nologin -c "Docker image user" $user \
 && chown -R $user:$group $homedir

### Setup Linter ###
ENV JSONLINT_VERSION 0.0.4

RUN npm install -g durable-json-lint-cli@$JSONLINT_VERSION

### Defaults ###
USER $user
WORKDIR $homedir
