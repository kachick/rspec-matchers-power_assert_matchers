# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe RSpec::Matchers::PowerAssertMatchers do
  describe RSpec::Matchers::PowerAssertMatchers::VERSION do
    it do
      expect(RSpec::Matchers::PowerAssertMatchers::VERSION.frozen?).to eq(true)
      expect(Gem::Version.correct?(RSpec::Matchers::PowerAssertMatchers::VERSION)).to eq(true)
    end
  end

  describe 'PowerAssert integrations' do
    it do
      pa_constant = nil
      ::PowerAssert.class_exec do
        pa_constant = const_get(:INTERNAL_LIB_DIRS).fetch(RSpec::Matchers::PowerAssertMatchers)
      end

      expect(pa_constant).to match(%r{\bpower_assert_matchers/lib\z})
    end
  end

  # refs: https://github.com/rspec/rspec-expectations/blob/040d1b0bba83031c9ae432fd3a4462fdd1cc74e7/spec/rspec/matchers/define_negated_matcher_spec.rb
  describe 'be_assert' do
    it 'has special description' do
      expect(be_assert.description).to eq('as a be_truthy with power_assert')
    end

    it 'passes if the block returns truthy' do
      expect {
        '0'.class != '3'.to_i.times.map {|i| i + 1 }.class
      }.to be_assert
    end

    it 'shows power assert reports if the block returns falsy' do
      pa_inspection =<<'OUTPUT'
          '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
              |     |      |    |     |                |
              |     |      |    |     |                Array
              |     |      |    |     [1, 2, 3]
              |     |      |    #<Enumerator: ...>
              |     |      3
              |     false
              String
OUTPUT

      expect {
        expect {
          '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
        }.to be_assert
      }.to fail do |err|
        # refs
        #  * https://twitter.com/_kachick/status/1395003251620151302
        #  * https://stackoverflow.com/questions/16032726/removing-color-decorations-from-strings-before-writing-them-to-logfile/35894736#35894736
        expect(err.message.gsub(/\e\[([;\d]+)?m/, '')).to eq(pa_inspection.chomp)
      end
    end

    it 'shows power assert reports with colorized inspection', skip: 'Need to investigate how to test :)' do
      expect {
        expect {
          '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
        }.to be_assert
      }.to fail_with(IRB::Color.colorize(<<~'RUBY'
      '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
          |     |      |    |     |                |
          |     |      |    |     |                Array
          |     |      |    |     [1, 2, 3]
          |     |      |    #<Enumerator: ...>
          |     |      3
          |     false
          String
      RUBY
      ))
    end
  end
end
