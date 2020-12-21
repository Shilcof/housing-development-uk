source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', '~> 6.0.0', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'sinatra-flash'
gem 'dotenv'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem 'hashids'
gem 'foreman'

group :development do
  gem 'sqlite3'
  gem 'shotgun'
  gem 'pry'
  gem 'tux'
end

group :production do
  gem 'pg', '~> 0.20'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
