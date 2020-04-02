FROM ruby:2.6.5-alpine
RUN apk update && apk add nodejs yarn postgresql-client postgresql-dev tzdata build-base
RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.1.2
RUN bundle install --deployment --without development test
COPY . /myapp
RUN yarn install

RUN bundle exec rails assets:precompile
RUN bundle exec rails db:migrate --trace

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
