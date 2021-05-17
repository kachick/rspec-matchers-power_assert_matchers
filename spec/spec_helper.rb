# coding: us-ascii
# frozen_string_literal: true

require 'rspec'

# ref: https://github.com/rspec/rspec-expectations/blob/43bf64b01f8356979ffbc373b2e81d2ab1389b29/lib/rspec/matchers/fail_matchers.rb
require 'rspec/matchers/fail_matchers'
RSpec.configure do |config|
  config.include RSpec::Matchers::FailMatchers
end

require 'warning'

if Warning.respond_to?(:[]=) # @TODO Removable this guard after dropped ruby 2.6
  Warning[:deprecated] = true
  Warning[:experimental] = true
end

Gem.path.each do |path|
  Warning.ignore(//, path)
end

Warning.process do |_warning|
  :raise
end

require_relative '../lib/rspec/matchers/power_assert_matchers'
