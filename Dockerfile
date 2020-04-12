FROM ruby:2.7
RUN apt-get update && apt-get install -y nodejs postgresql-client
RUN mkdir /pm_app_api
WORKDIR /pm_app_api
COPY . /pm_app_api
RUN bundle install

CMD ['rails', 'server', '-b', '0.0.0.0']