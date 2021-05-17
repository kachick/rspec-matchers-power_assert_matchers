# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2021 Kenichi Kamiya

require 'power_assert'
require 'power_assert/colorize'
require 'rspec'
require 'rspec/expectations'

module RSpec
  module Matchers
    module PowerAssertMatchers
    end
  end
end

# refs for implementations:
# * https://github.com/rspec/rspec-expectations/blob/43bf64b01f8356979ffbc373b2e81d2ab1389b29/lib/rspec/matchers.rb
# * https://github.com/rspec/rspec-expectations/blob/43bf64b01f8356979ffbc373b2e81d2ab1389b29/features/custom_matchers/define_block_matcher.feature
# * https://github.com/rspec/rspec-expectations/blob/040d1b0bba83031c9ae432fd3a4462fdd1cc74e7/lib/rspec/matchers/dsl.rb#L64-L78
RSpec::Matchers.define(:be_assert) do
  dsl_context = self

  # https://github.com/rspec/rspec-expectations/blob/040d1b0bba83031c9ae432fd3a4462fdd1cc74e7/lib/rspec/matchers/dsl.rb#L104-L142
  match(notify_expectation_failures: true) do |actual|
    case actual
    when Proc
      result = ::PowerAssert.start(actual, assertion_method: __callee__) do |pa|
        # https://github.com/rspec/rspec-expectations/blob/040d1b0bba83031c9ae432fd3a4462fdd1cc74e7/lib/rspec/matchers/dsl.rb#L200-L217
        # @TODO: Should simulate be_truthy message? https://github.com/rspec/rspec-expectations/blob/43bf64b01f8356979ffbc373b2e81d2ab1389b29/lib/rspec/matchers/built_in/be.rb#L7-L18
        dsl_context.failure_message do
          pa.message_proc.call
        end

        pa.yield
      end

      result
    when String
      raise NotImplementedError
    else
      actual
    end
  end

  supports_block_expectations

  description do
    'as a be_truthy with power_assert'
  end
end

require_relative 'power_assert_matchers/version'

module PowerAssert
  INTERNAL_LIB_DIRS[RSpec::Matchers::PowerAssertMatchers] = File.dirname(
    File.dirname(
      File.dirname(
        caller_locations(1, 1).first.path
      )
    )
  )
end
