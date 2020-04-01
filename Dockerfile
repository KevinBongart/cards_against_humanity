FROM ruby:2.6.5-alpine
RUN apk update && apk add nodejs yarn postgresql-client postgresql-dev tzdata build-base
RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY yarn.lock /myapp/yarn.lock
RUN gem install bundler:2.1.2
RUN bundle install --deployment --without development test
RUN bundle exec rake yarn:install

COPY . /myapp

ENV RAILS_ENV production
ENV RACK_ENV production
ENV PORT 80

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
