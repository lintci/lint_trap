FROM ubuntu:trusty
MAINTAINER Allen Madsen

###### Create user
ENV user spin_cycle
ENV group linters
ENV homedir /home/spin_cycle

RUN mkdir -p $homedir && \
    groupadd -r $group -g 777 && \
    useradd -u 666 -r -g $group -d $homedir -s /sbin/nologin -c "Docker image user" $user && \
    chown -R $user:$group $homedir

###### Packages
USER root

RUN apt-get update && apt-get install -y \
    bzr \
    cvs \
    git \
    mercurial \
    subversion \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    curl \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

###### Languages

### Node.js
RUN apt-get update && apt-get install -y \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# verify gpg and sha256: http://nodejs.org/dist/v0.10.31/SHASUMS256.txt.asc
# gpg: aka "Timothy J Fontaine (Work) <tj.fontaine@joyent.com>"
RUN gpg --keyserver pgp.mit.edu --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D

ENV NODE_VERSION 0.10.35
ENV NPM_VERSION 2.1.16

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
  && npm install -g npm@"$NPM_VERSION" \
  && npm cache clear

### Ruby
RUN apt-get update && apt-get install -y \
    curl \
    procps \
  && rm -rf /var/lib/apt/lists/*

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.0

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN apt-get update \
  && apt-get install -y bison ruby \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /usr/src/ruby \
  && curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
    | tar -xjC /usr/src/ruby --strip-components=1 \
  && cd /usr/src/ruby \
  && autoconf \
  && ./configure --disable-install-doc \
  && make -j"$(nproc)" \
  && apt-get purge -y --auto-remove bison ruby \
  && make install \
  && rm -r /usr/src/ruby

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

### Java
RUN apt-get update && apt-get install -y \
    default-jre \
 && rm -rf /var/lib/apt/lists/*

### Go
# SCMs for "go get", gcc for cgo
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gcc \
    libc6-dev \
    make \
    bzr \
    git \
    mercurial \
    --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.4

RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz | tar -v -C /usr/src -xz \
 && cd /usr/src/go/src \
 && ./make.bash --no-clean 2>&1

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src
ENV GOPATH /go
ENV PATH /go/bin:$PATH

### Python
# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PYTHON_VERSION 2.7.9

RUN set -x \
 && mkdir -p /usr/src/python \
 && curl -SL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" \
   | tar -xJC /usr/src/python --strip-components=1 \
 && cd /usr/src/python \
 && ./configure --enable-shared \
 && make -j$(nproc) \
 && make install \
 && ldconfig \
 && curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
 && find /usr/local \
   \( -type d -a -name test -o -name tests \) \
   -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
   -exec rm -rf '{}' + \
 && rm -rf /usr/src/python

###### Linters

### CPPCheck
RUN apt-get update && apt-get install -y \
    cppcheck \
  && rm -rf /var/lib/apt/lists/*

### GoLint
RUN go get github.com/golang/lint/golint

### JSHint, CSSLint, JSONLint, CoffeeLint
RUN npm install -g \
    jshint \
    csslint \
    durable-json-lint-cli \
    coffeelint

### PyLint
RUN pip install pylint

### RuboCop, SCSSLint
RUN gem install rubocop scss-lint

###### Display Versions
RUN echo 'CPPCheck' && cppcheck --version && echo \
 && echo 'Go' && go version && echo \
 && echo 'GoLint' && which golint && echo \
 && echo 'Java' && java -version && echo \
 && echo 'JavaScript' && node --version && echo \
 && echo 'JSHint' && jshint --version && echo \
 && echo 'CSSLint' && csslint --version && echo \
 && echo 'JSONLint' && durable-json-lint --version && echo \
 && echo 'Python' && python --version && echo \
 && echo 'PyLint' && pylint --version && echo \
 && echo 'Ruby' && ruby --version && echo \
 && echo 'RuboCop' && rubocop --version && echo \
 && echo 'SCSSLint' && scss-lint --version && echo

###### Finally
USER $user
WORKDIR $homedir
