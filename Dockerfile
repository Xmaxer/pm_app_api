FROM ruby:2.7.0
RUN apt-get update && apt-get install -y nodejs postgresql-client
RUN mkdir /pm_app_api
WORKDIR /pm_app_api
COPY . /pm_app_api
COPY https://github.com/vishnubob/wait-for-it/blob/master/wait-for-it.sh /pm_app_api
RUN bundle install

ENTRYPOINT ["./entrypoint.sh"]