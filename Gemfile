source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

# Accessing REST services in a flexible way
# https://github.com/flexirest/flexirest
gem "flexirest", "~> 1.12.5"

# Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 4+
gem "kaminari", "~> 1.2.2"

# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem "active_model_serializers", "~> 0.10.15"

# Link header pagination for Rails and Grape APIs
gem "api-pagination", "~> 6.0.0"

# Use Redis as our Rails cache store
gem "redis-rails", "~> 5.0.2"

# For background execution
gem "sidekiq", "~> 6.5.10"

# A scheduler process to replace cron, using a more flexible Ruby syntax running as a single long-running process.
gem "clockwork", "~> 3.0.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Creates fake (but reasonable) data that can be used during testing or development
  gem "faker", "~> 3.5.1"
  # Autoload dotenv in Rails
  gem "dotenv-rails", "~> 3.1.8"
end

group :development do
  # Static code analyzer and formatter
  gem "rubocop", "~> 1.78.0", require: false
  gem "rubocop-rails", "~> 2.33.3", require: false
  gem "rubocop-rspec", "~> 3.6.0", require: false
end

group :test do
  # RSpec testing framework as a drop-in alternative to Rails"s default testing framework, Minitest.
  gem "rspec-rails", "~> 8.0.1"
  # fuubar is an instafailing RSpec formatter that uses a progress bar instead of a string of letters and dots as feedback
  gem "fuubar", "~> 2.5.1"
  # A fixtures replacement with a straightforward definition syntax
  gem "factory_bot_rails", "~> 6.5.0"
  # One-liners to test common Rails functionality
  gem "shoulda-matchers", "~> 6.5.0"
  # "time travel" and "time freezing" capabilities, to test time-dependent code
  gem "timecop", "~> 0.9.10"
end
