# coding: us-ascii
# frozen_string_literal: true

require 'rspec'

# ref: https://github.com/rspec/rspec-expectations/blob/43bf64b01f8356979ffbc373b2e81d2ab1389b29/lib/rspec/matchers/fail_matchers.rb
require 'rspec/matchers/fail_matchers'

RSpec.configure do |config|
  config.include RSpec::Matchers::FailMatchers

  config.disable_monkey_patching!
  config.warnings = true
  config.raise_on_warning = true

  # See https://github.com/rspec/rspec-expectations/blob/61fe1bc203fa7b906d3034401fa90f1115cb48ae/lib/rspec/expectations/configuration.rb
  config.expect_with(:rspec) do |expect_config|
    expect_config.syntax = :expect
    if Gem::Version.new(RSpec::Version::STRING) >= Gem::Version.new('3.10.0')
      expect_config.strict_predicate_matchers = true
    end
    expect_config.include_chain_clauses_in_custom_matcher_descriptions = true
    expect_config.on_potential_false_positives = :raise
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
end

require 'warning'

Warning[:deprecated] = true
Warning[:experimental] = true

Gem.path.each do |path|
  Warning.ignore(//, path)
end

Warning.process do |_warning|
  :raise
end

# https://github.com/kachick/rspec-matchers-power_assert_matchers/issues/191
# https://github.com/ruby/ruby/blob/e5b585ba908d371c67d97988795a5e40ec2f9e93/lib/prettyprint.rb#L184
require 'prettyprint'
Warning.ignore(/literal string will be frozen in the future/, PrettyPrint.instance_method(:text).source_location.first)

require_relative '../lib/rspec/matchers/power_assert_matchers'
