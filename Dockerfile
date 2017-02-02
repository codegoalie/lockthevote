FROM ruby:2.4.0

ENV APP_HOME /lockthevote

RUN mkdir $APP_HOME && mkdir -p /var/bundle

WORKDIR $APP_HOME

RUN apt-get update -qq \
  && apt-get install --no-install-recommends -y \
     build-essential \
     git-core \
     libpq-dev \
     libxml2-dev \
     libxslt1-dev \
     libqt4-webkit \
     libqt4-dev \
     xvfb \
     nodejs \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor/cache vendor/cache

RUN bundle install --path /var/bundle

COPY config/application.rb config/application.rb
COPY bin bin
RUN bundle exec spring binstub --all

COPY . .
