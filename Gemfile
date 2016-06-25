source 'https://rubygems.org'
ruby '2.3.1'

# Rails core gems
gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sqlite3'

# Users
gem 'devise', '~> 4.1', '>= 4.1.1'
gem 'devise-bootstrap-views'
gem 'cancancan', '~> 1.13', '>= 1.13.1'
gem 'rolify', '~> 5.0'
gem 'activeadmin', github: 'activeadmin'
gem 'omniauth-google-oauth2'

# Form
gem 'simple_form', '~> 3.2', '>= 3.2.1'

# Tamplate
gem 'slim-rails'

# Style
gem 'bootstrap-sass', '~> 3.3.6'

# secure config keys
gem 'figaro', '~> 1.1', '>= 1.1.1'

# others
gem 'responders'

# Api gems
gem 'active_model_serializers'

# Schema and routes info
gem 'annotate'

group :development, :test do
  gem 'byebug'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'poltergeist'
  gem 'timecop'
  gem 'rspec-core'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
end

group :test do
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
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

# group :production do
#   gem 'pg', '~> 0.18.4'
#   gem 'rails_12factor', '~> 0.0.3'
# end
