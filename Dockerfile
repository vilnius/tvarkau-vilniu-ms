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

ADD . $APP_HOME
RUN chmod +x $APP_HOME/docker-entrypoint.sh
RUN chmod +x $APP_HOME/docker-entrypoint-test.sh
RUN chmod +x $APP_HOME/wait-for-it.sh

EXPOSE 3000
