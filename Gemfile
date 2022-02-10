source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.1"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "turbo-rails"
gem "stimulus-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"

gem "jbuilder"

gem 'sidekiq'
gem "redis", "~> 4.0"
gem 'redis-rails'
gem 'rails_autoscale_agent'

gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise-i18n'

gem "cancancan", "~> 3.3"

gem "omniauth", "~> 2.0"
gem "omniauth-github", "~> 2.0"
gem 'omniauth-rails_csrf_protection', '~> 1.0', '>= 1.0.1'

gem "bootstrap_form", "~> 5.0"
gem "devise-bootstrap5", "~> 0.1.3"

gem "faker", "~> 2.19"

gem "gems"

gem 'store_attribute'

gem "shrine", "~> 3.4"
gem "fastimage", "~> 2.2"
gem "aws-sdk-s3", "~> 1.112"
gem "image_processing", "~> 1.12"

gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

group :development do
  gem 'rails-erd'
  gem 'annotate'
  gem 'web-console'
  gem "memory_profiler"
  gem 'derailed_benchmarks'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'active_record_doctor'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
end