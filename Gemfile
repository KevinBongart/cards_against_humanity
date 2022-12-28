# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').chomp

gem 'aasm'
gem 'acts_as_list'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap'
gem 'flipper'
gem 'flipper-redis'
gem 'flipper-ui'
gem 'jbuilder', '~> 2.11'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'newrelic_rpm'
gem 'okcomputer'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_query', '>= 0.9.0'
gem 'pghero'
gem 'puma', '~> 6.0'
gem 'rails', '~> 6.1.7'
gem 'redis', '< 5'
gem 'rollbar'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.8'
  gem 'rails_real_favicon'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec_junit_formatter'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
