source 'https://rubygems.org'

# Rails core gems
gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Database
gem 'pg'

# Users
gem 'devise', '~> 4.1', '>= 4.1.1'
gem 'devise-bootstrap-views'
gem 'cancancan', '~> 1.13', '>= 1.13.1'
gem 'rolify', '~> 5.0'
gem 'activeadmin', github: 'activeadmin'
gem 'omniauth-google-oauth2', '~> 0.4.1'

# Form
gem 'simple_form', '~> 3.2', '>= 3.2.1'

# Tamplate
gem 'slim-rails'

# Style
gem 'bootstrap-sass', '~> 3.3.6'

group :development, :test do
  gem 'byebug'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'poltergeist'
  gem 'timecop'
  gem 'rspec-core'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem "shoulda-callback-matchers"
end

group :development do
  gem 'rubocop', require: false
  gem 'pry'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end
