FROM ruby:2.6.5-alpine
RUN apk update && apk add nodejs yarn postgresql-client postgresql-dev tzdata build-base
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.1.2
RUN bundle install --deployment --without development test
COPY . /myapp
RUN bundle exec rake yarn:install
ENV RAILS_ENV production
ENV RACK_ENV production
ENV PORT 80

EXPOSE 80

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
