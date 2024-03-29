source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '< 6.0.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# This^ gem should be unnecessary because SDE is not an API

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :production do
  gem 'aws-sdk-s3'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Logs outgoing HTTP requests. Used for debugging.
  gem 'httplog'
  # RSpec for testing
  gem "rspec-rails"
  # Factory Bot for dynamic test fixture generation
  gem 'factory_bot_rails'
  # For starting Rails, Redis, and Sidekiq simultaneously and cohesively
  gem 'foreman'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Annotate automatically adds comments to each model class file, listing the model’s attributes and their types.
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # Async is used as the ActiveJob adapter to make tests run faster
  gem 'async'
end

# Adds custom css themes
gem 'bootswatch-rails'
gem 'bootstrap'

# Handles authentication for user accounts
gem 'devise'

# Prawn PDF generation
gem 'prawn'

# Humanize spells out large numbers with a simple method .humanize() like this: 152.humanize will evaluate to "one hundred and fifty two"
gem 'humanize'

# For interacting with the DocuSign API
gem 'docusign_esign'

# For authenticating with the DocuSign API
gem 'jwt'

# Payment Processor
gem 'stripe'

# For icons
gem "font-awesome-sass"

# For background job-processing
gem 'sidekiq'

# For signature block detection. This will be added later.
# gem 'rmagick'
# gem 'rtesseract'

# Redis for background job queueing
gem 'redis', '< 5'

# Rmagick for converting PDFs to images
gem 'rmagick'