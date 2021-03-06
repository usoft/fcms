source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :test do
  gem 'simplecov', '0.7.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'selenium-client'
  gem 'selenium-webdriver', '2.32.1'
  gem 'capybara', '2.1.0'                                 # lets Cucumber pretend to be a web browser
  #gem 'metric_fu', '4.1.3'
end

# add to end of Gemfile
group :development, :test do
  #gem 'debugger', '1.6.0'                                 # use Ruby debugger
  gem 'database_cleaner', '1.0.1'                         # to clear Cucumber's test database between runs
  gem 'launchy', '2.3.0'                                  # a useful debugging aid for user stories
  gem 'better_errors', '0.8.0'
  gem 'rspec-rails', '2.13.1'
  gem 'cucumber-rails', '1.3.1', :require => false
  gem 'cucumber-rails-training-wheels', '1.0.0'
  gem 'email_spec'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'therubyracer', '0.11.4'
  gem 'uglifier', '2.1.1'
  gem 'yui-compressor', '0.9.6'
end

# Datatables
gem 'sass-rails',   '3.2.3'
gem 'bootstrap-sass', '2.0.2'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'ajax-datatables-rails'

# Navigation
gem 'simple-navigation', '3.11.0'

# Javascript and CSS libraries
gem 'jquery-rails', '2.2.1'
gem 'remotipart', '1.0.5'
gem 'twitter-bootstrap-rails', '2.2.6'
gem 'jasny_bootstrap_extension_rails', '0.0.1'
gem 'font-awesome-rails', '~> 3.2.1.2'
gem 'underscore-rails', '1.4.4'

# Form validation
gem 'simple_form', '2.1.0'
gem 'nested_form', '0.3.2'
gem 'client_side_validations', '3.2.5'
gem 'client_side_validations-simple_form', '2.1.0'
gem 'rails-i18n', '0.7.3'

# MySQL gem
gem 'mysql2', '0.3.11'
gem 'foreigner', '1.4.1'

# Datatables
gem 'will_paginate'

# Captcha
gem 'recaptcha', '~> 0.3.5'

# Devise gem
gem 'devise', '2.2.4'
gem 'devise_invitable', '~> 1.1.0'

# Authorizations
gem 'cancan', '1.6.10'

# Autocomplete
gem 'rails3-jquery-autocomplete', '1.0.11'

# Select2 gem
gem 'select2-rails', '3.4.3'

# Excel
gem 'spreadsheet', '~> 0.8.5'
gem 'axlsx', '1.3.6'
#gem 'acts_as_xlsx', '1.0.6'

# Charts
#gem 'gruff', '0.3.7'
gem 'igs_pie_chart'

# Prevent old browser
gem 'browser', '0.2.0'

# WYSIWYG editor
gem 'ckeditor_rails', '4.1.3'

# YARD documentation
gem 'yard', '0.8.7'
gem 'redcarpet', '3.0.0'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
