FROM ruby:2.3.1

RUN apt-get update -qq
RUN apt-get install -y \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  mysql-client \
  nodejs \
  cmake

RUN gem install bundler

ENV BUNDLE_PATH /box/.bundle
ENV APP_HOME /opt/tvarkau-vilniu

WORKDIR $APP_HOME

EXPOSE 3000

ADD . $APP_HOME
