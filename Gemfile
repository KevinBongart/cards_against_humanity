# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'aasm'
gem 'acts_as_list'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap'
gem 'jbuilder', '~> 2.7'
gem 'newrelic_rpm'
gem 'okcomputer'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_query', '>= 0.9.0'
gem 'pghero'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'redis'
gem 'rollbar'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

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
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'rails_real_favicon'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec_junit_formatter'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
