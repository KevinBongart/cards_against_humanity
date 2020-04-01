module Admin
  class AdminController < ApplicationController
    private

    def authenticate
      return unless Rails.env.production?

      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == ENV.fetch('HTTP_BASIC_USERNAME') && password == ENV.fetch('HTTP_BASIC_PASSWORD')
      end
    end
  end
end
