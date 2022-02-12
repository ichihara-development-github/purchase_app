source 'https://rubygems.org'
#---------------------------later installed-------------------------

gem 'bootstrap', '~> 4.4'
gem 'rails-i18n'
gem 'stripe'
gem 'will_paginate-bootstrap4'

gem 'carrierwave'
gem 'fog-aws'
gem 'aws-ses' , '~> 0.7'
gem 'aws-sdk-rails'

gem 'line-bot-api'

gem 'recaptcha', require: "recaptcha/rails"

gem 'mail-iso-2022-jp'
gem 'mysql2'

gem 'geocoder'
gem 'http'

gem 'listen', '~> 3.0.5'


platforms :ruby do
  gem 'unicorn', require: false
  gem 'mini_racer'
end
#-------------------------------------------------------------------
gem 'rails', '~> 5.1.7'
# Use sqlite3 as the database for Active Record
# Use Puma as the app serve
gem 'gon'

gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-turbolinks'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', '~> 9.0', '>= 9.0.6', platform: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~>3.6'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
end

group :production do
  gem 'mimemagic', '0.3.9'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'

  gem 'rubocop', require: false
  gem 'rubocop-rails'

  gem 'capistrano', '3.12.0'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
