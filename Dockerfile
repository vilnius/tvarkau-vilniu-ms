FROM ruby:2.3.1

RUN apt-get update -qq
RUN apt-get install -y \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  nodejs \
  cmake

RUN gem install bundler

ENV APP_HOME /opt/tvarkau-vilniu
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

EXPOSE 3000

ENTRYPOINT ./wait-for-it.sh db:5432 -- ./wait-for-it.sh mysql:3306 -t 60 -- ./docker-entrypoint.sh

ADD . $APP_HOME
