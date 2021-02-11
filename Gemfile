source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.4'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 3.34'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :development do
  gem 'better_errors', '~> 2.8', '>= 2.8.3'
  gem 'binding_of_caller', '~> 1.0'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
