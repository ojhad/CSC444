source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
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
#gem 'bcrypt', '~> 3.1.7'
# Use to annotate models
gem 'annotate', require: false
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'geocoder'
gem 'underscore-rails'
gem 'gmaps4rails'
gem 'paypal-sdk-rest'
gem 'stripe'
gem "letter_opener", :group => :development
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'gon'

##################################################
# PROJECT SPECIFIC GEMS
##################################################
gem 'coffee-script-source', '1.8.0'
gem 'devise', '~> 4.2'
gem 'jquery-ui-rails'
gem 'jt-rails-address', '~> 1.0'
gem 'twitter-bootstrap-rails', '~> 3.2', '>= 3.2.2'
#Needed for Windows 10 machines
gem 'bcrypt', platforms: :ruby
gem 'data-confirm-modal'
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'paperclip', '~> 5.0.0'
gem 'os'
gem 'wicked'
gem 'pretender'
gem 'rails_12factor'
gem 'geokit-rails'


