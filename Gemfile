source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.1'

gem 'active_model_serializers', '~> 0.9.3'

group :doc do    
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.1'
end

# Authentication
gem 'omniauth', '~> 1.2.2'
gem 'dotenv-rails', '~> 2.0.1'
gem 'devise', '~> 3.4.1'
gem 'doorkeeper', '~> 2.1.4'
gem 'rolify', '~> 4.0.0'
gem 'cancan', '~> 1.6.10'

group :development do
	gem 'thin', '~> 1.6.3'
	gem 'annotate', '~> 2.6.8'
	gem 'awesome_print', '~> 1.6.1'
	gem 'rails-erd', '~> 1.3.1'

  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-passenger', '~> 0.0.4'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 4.0.5'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.1.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.3'

  gem 'rspec-rails', '~> 3.2.1'
  gem 'rspec-http', '~> 0.11.0'
end

group :test do
	gem 'factory_girl_rails', '~> 4.5.0'
	gem 'faker', '~> 1.4.3'
end

