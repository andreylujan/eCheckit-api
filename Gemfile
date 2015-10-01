source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.3'

gem 'active_model_serializers', '~> 0.9.3'

group :doc do    
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.1'
end

# Authentication
gem 'omniauth', '~> 1.2.2'
gem 'dotenv-rails', '~> 2.0.2'
gem 'devise', '~> 3.5.2'
gem 'doorkeeper', '~> 3.0.1'
gem 'rolify', '~> 4.1.1'
gem 'cancan', '~> 1.6.10'
gem 'gmail', '~> 0.6.0'
gem 'awesome_print', '~> 1.6.1'
gem 'apipie-rails', :github => 'Apipie/apipie-rails'
gem 'erubis', '~> 2.7.0'
gem 'wicked_pdf', '~> 0.11.0'
gem 'wkhtmltopdf-binary', '~> 0.9.9.3'
gem 'aws-sdk', '~> 2.1.24'
gem 'faraday', '~> 0.9.1'
gem 'sidekiq', '~> 3.5.0'
gem 'net-ssh', '~> 3.0.1'
gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
gem 'paranoia', '~> 2.1.3'

group :development do
  gem 'mailcatcher', '~> 0.6.1'
	gem 'annotate', '~> 2.6.10'	
	gem 'rails-erd', '~> 1.3.1'
  gem 'capistrano-rails', '~> 1.1.3'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-passenger', '~> 0.0.5'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 6.0.2'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.2.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.4.0'
  gem 'rspec-rails', '~> 3.3.3'
  gem 'rspec-http', '~> 0.11.0'
end

group :test do
	gem 'factory_girl_rails', '~> 4.5.0'
	gem 'faker', '~> 1.5.0'
end

