# frozen_string_literal: true
source 'https://rubygems.org'

gem 'rails', '5.0.0.1'

# Database
gem 'pg'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'oj'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'draper', '3.0.0.pre1'
gem 'font-awesome-rails'
gem 'gretel'

# ES6 Transpiling
gem 'browserify-rails'

# File Uploading
gem 'shrine'
gem 'mini_magick'
gem 'fastimage'
gem 'roda'
gem 'aws-sdk'
gem 'image_processing'

# Forms
gem 'simple_form'
gem 'kaminari'
gem 'nested_form'

# Static Pages
gem 'high_voltage'

# API
gem 'active_model_serializers'

# Documentation
gem 'annotate'

# Auditing
gem 'paper_trail'

# Robots.txt
gem 'roboto'

# Server
gem 'puma'
gem 'dalli'
gem 'kgio'
gem 'rack-cache', :require => 'rack/cache'
gem 'rack-timeout'
gem 'lograge'
gem 'figaro'

# Error Tracking
gem 'honeybadger'

# Authentication
gem 'devise'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'guard-rspec', require: false
  gem 'guard-cucumber'
  gem 'guard-brakeman'
  gem 'guard-livereload', require: false
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent'
  gem 'web-console', '~> 2.0'
  gem 'bullet'
  gem 'letter_opener'
end

group :development, :test do
  gem 'byebug'
  gem 'rb-readline' # fix for byebug on Mac OSX Sierra
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'faker'
  gem 'timecop'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'launchy'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'rails-controller-testing'
  gem 'codeclimate-test-reporter', require: nil
end
