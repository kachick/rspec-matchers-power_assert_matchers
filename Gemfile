# coding: us-ascii
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.3.0'
end

group :development do
  # Don't relax rubocop family versions with `~> the_version`, rubocop often introduce breaking changes in patch versions. See ruby-ulid#722
  gem 'rubocop', '1.79.1', require: false
  gem 'rubocop-rake', '0.7.1', require: false
  # rubocop-rspec: Intentional ignored
end

group :test do
  gem 'rspec', '~> 3.13.1'
  gem 'warning', '~> 1.5.0'
end
