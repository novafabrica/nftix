source 'https://rubygems.org'

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'
gem 'pg'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'thin'
  gem "steak"
  gem 'capistrano-novafabrica', :git => 'https://github.com/novafabrica/nf-cap-plugin'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rspec-rails',        :git => 'git://github.com/rspec/rspec-rails.git'
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"
  gem 'factory_girl'
  gem 'ffaker'
end

group :test do
  # Pretty printed test output
  gem 'simplecov', :require => false # Will install simplecov-html as a dependency
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem "timecop"
end