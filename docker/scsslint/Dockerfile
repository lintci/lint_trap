FROM ruby:2.2.2-slim
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
ENV SCSSLINT_VERSION 0.38.0

RUN gem install scss-lint:$SCSSLINT_VERSION

### Defaults ###
USER $user
WORKDIR $homedir
