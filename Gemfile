source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'bcrypt', '~> 3.1.7'
# gem 'mini_racer', platforms: :ruby
# gem 'redis', '~> 4.0'
# Install wdm Gem if the platform is Windows
# See https://github.com/rails/execjs#readme for more supported runtimes
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Use ActiveModel has_secure_password
# Use CoffeeScript for .coffee assets and views
# Use Puma as the app server
# Use Redis adapter to run Action Cable in production
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.4'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'devise'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :test do
  gem 'rspec'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~>0.81.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# group :production do
#   # Use postgresql as the database for Active Record
#   gem 'pg', '>= 0.18', '< 2.0'
# end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
