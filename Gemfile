source 'http://rubygems:9292'

case RUBY_PLATFORM
  when /i386-mingw32/
    ruby '1.9.3'
  when /java/
    ruby '2.0.0', :engine => 'jruby', :engine_version => '1.7.16'
  else
    raise RuntimeError "Invalid OS #{RUBY_PLATFORM}"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
# Use jdbcsqlite3 as the database for Active Record
# gem 'activerecord-jdbcsqlite3-adapter'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyrhino'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',                              group: :doc

gem 'bootstrap-sass', '3.3.1.0'
gem 'tzinfo-data'

gem 'haml-rails'
gem 'simple_form'
gem 'activerecord-jdbcsqlite3-adapter'#, '1.3.0.beta2'
gem 'mongo'
gem 'devise'

group :test do
  gem 'rspec-rails'
  gem 'pry'
end

group :development do
# Use Capistrano for deployment
  gem 'capistrano-rails'
  gem 'jruby-pageant'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use puma as the app server
gem 'puma'

