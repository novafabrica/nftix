source 'https://rubygems.org'

gem 'rails',     github: 'rails/rails', ref: '202041e762a98cb433c3a24a0b03308d4e05a99d'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'
gem 'pg'
gem 'bcrypt-ruby'
gem 'jquery-rails', :git => 'git://github.com/rails/jquery-rails.git'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'sunspot'
gem 'sidekiq'
gem 'nice_password'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', :branch => 'static'
gem 'foreman'
gem 'redcarpet'
gem 'mailman'
gem 'yajl-ruby'
gem 'unicorn'
gem "github_api"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'annotate'
  gem 'mail_view'
end

group :development, :test do
  gem 'thin'
  gem "steak"
  gem 'capistrano-novafabrica', :git => 'https://github.com/novafabrica/nf-cap-plugin'
  gem 'capistrano', github: 'capistrano/capistrano', ref: '96a16'
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