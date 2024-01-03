source "https://rubygems.org"

ruby "3.2.2"

group :development, :test do
  gem "brakeman", require: false
  gem "bullet"
  gem "bundler-audit", require: false
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails"
  gem "fasterer", require: false
  gem "reek", require: false
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers"
end

group :development do
  gem "annotate"
  gem "lefthook", require: false
  gem "rails_best_practices", require: false
  gem "spring"
end

group :test do
  gem "simplecov", require: false
end

gem "dotenv-rails"
gem "lograge"
gem "multi_json"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 7.1.2"

gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
