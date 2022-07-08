# coding: us-ascii
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.0.6'
end

group :development do
  gem 'rubocop', require: false, git: 'https://github.com/kachick/rubocop', ref: 'fix-wrog-detection-for-all-methods'
  gem 'rubocop-rake', '~> 0.6.0', require: false
  gem 'rubocop-performance', '~> 1.14.2', require: false
  gem 'rubocop-rubycw', '~> 0.1.6', require: false
  gem 'rubocop-md', '~> 1.0.1', require: false
  # rubocop-rspec: Intentional ignored
end

group :test do
  gem 'rspec', '~> 3.11.0'
  gem 'warning', '~> 1.2.1'
end
