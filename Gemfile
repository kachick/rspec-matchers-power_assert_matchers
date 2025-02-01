# coding: us-ascii
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.2.1'
end

group :development do
  gem 'rubocop', '~> 1.69.2', require: false
  gem 'rubocop-rake', '~> 0.6.0', require: false
  # rubocop-rspec: Intentional ignored
end

group :test do
  gem 'rspec', '~> 3.13.0'
  # Required to drop ostruct for ruby 3.5 or later.
  # See below commits
  #   - https://github.com/rspec/rspec/commit/07a5612bf96427e24e50a6e975a71784d340dd2b
  #   - https://github.com/rspec/rspec/commit/3fc400f466e30d1df19688df6164bf2b5937f570
  gem 'rspec-core', '~> 3.13.2'
  gem 'warning', '~> 1.5.0'
end
