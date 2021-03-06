source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Swagger tooling for Rails API's
gem 'rswag','~> 1.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'

# Use postgres as the database for Active Record
gem 'pg', '~> 0.21'

# Use Puma as the app server
gem 'puma', '~> 3.9.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use Devise for Authentication Models
gem 'devise', '~> 4.3'

# Use JWT to allow token based authentication
gem 'jwt'

# The simple command gem is an easy way of creating services
gem 'simple_command','~> 0.0.9'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

    # factory_girl provides a framework and DSL for defining and using factories - less error-prone,
  # more explicit, and all-around easier to work with than fixtures.
  gem 'factory_girl','~> 4.8.0'
  gem 'factory_girl_rails','~> 4.8.0'

  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data:
  # names, addresses, phone numbers, etc.
  gem 'faker','~> 1.7.3'

  # Strategies for cleaning databases. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '>=1.6.1'

  # RSpec and RSpec for Rails
  gem 'rspec','~> 3.6.0'
  gem 'rspec-rails','~> 3.6.0'
  gem 'rails-controller-testing','~> 1.0.2'
  gem 'shoulda','~> 3.5.0'
  gem 'shoulda-matchers'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring','~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
