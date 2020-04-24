# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 10)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 20)
threads threads_count, threads_count

preload_app!
rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'
#bind "unix:/home/cardsagainst/my_app.sock"
on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
