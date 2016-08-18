source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'

gem 'active_model_serializers', '~> 0.9.4'


# Authentication
gem 'dotenv-rails', '~> 2.0.2'
gem 'devise', '~> 3.5.3'
gem 'doorkeeper', '~> 3.1.0'
gem 'rolify', '~> 5.0.0'
gem 'cancan', '~> 1.6.10'
gem 'gmail', '~> 0.6.0'
gem 'awesome_print', '~> 1.6.1'
gem 'erubis', '~> 2.7.0'
gem 'wicked_pdf', '~> 1.0.3'
gem 'wkhtmltopdf-binary', '~> 0.9.9.3'
gem 'aws-sdk', '~> 2.2.9'
gem 'faraday', '~> 0.9.2'
gem 'sidekiq', '~> 4.0.2'
gem 'net-ssh', '~> 3.0.2'
gem 'paranoia', '~> 2.1', '>= 2.1.5'
gem 'versionist', '~> 1.4', '>= 1.4.1'

group :development do
	gem 'annotate', '~> 2.7.0'	
	gem 'rails-erd', '~> 1.4.4'
  gem 'capistrano-sidekiq', git: 'https://github.com/pelluch/capistrano-sidekiq'
  gem 'capistrano-rails', '~> 1.1.5'
  gem 'capistrano-rbenv', '~> 2.0', '>= 2.0.4'
  gem 'capistrano-passenger', '~> 0.2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 8.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.6.1'
  gem 'rspec-rails', '~> 3.4.0'
  gem 'whenever', require: false
  gem 'rspec-http', '~> 0.11.0'
  gem 'thin', '~> 1.6', '>= 1.6.4'
end

group :test do
	gem 'factory_girl_rails', '~> 4.5.0'
	# gem 'faker', '~> 1.6.1'
end

