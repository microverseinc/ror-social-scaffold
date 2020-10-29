source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bootstrap-sass', '3.4.1'
gem 'carrierwave', '~> 2.1'
gem 'mini_magick', '~> 4.10', '>= 4.10.1'
gem 'rails', '~> 6.0', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.2', '>= 5.2.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# Use omniauth-facebook gem allows Facebook login integration
gem 'omniauth-facebook', '~> 7.0'
# Hirb gem organizes the display for active record information into tables when using the rails console; eg.
# After opening rails console type Hirb.enable to activate it
gem 'hirb', '~> 0.7.3'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
gem 'faker', '~> 2.14'
# will_paginate provides a simple API for performing paginated queries with Active Record,
# DataMapper and Sequel, and includes helpers for rendering pagination links in Rails,
# Sinatra, Hanami, and Merb web apps.
gem 'will_paginate', '~> 3.3'
# Hooks into will_paginate to format the html to match Twitter Bootstrap styling
gem 'bootstrap-will_paginate', '~> 1.0'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'devise'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'

  # A Ruby gem to load environment variables from `.env` files.
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 1.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'table_print'
  # help to kill N+1 queries and unused eager loading.
  gem 'bullet', '~> 6.1'
end

group :test do
  gem 'capybara', '~> 3.33'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.7'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
