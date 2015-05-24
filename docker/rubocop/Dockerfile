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
ENV RUBOCOP_VERSION 0.31.0

RUN gem install rubocop:$RUBOCOP_VERSION

### Defaults ###
USER $user
WORKDIR $homedir
