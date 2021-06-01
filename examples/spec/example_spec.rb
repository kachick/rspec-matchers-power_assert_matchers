# frozen_string_literal: true
require_relative 'spec_helper'

RSpec.describe RSpec::Matchers::PowerAssertMatchers do
  context 'when the given block returns falsy' do
    it 'shows power_assert inspection' do
      expect {
        '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
      }.to be_assert
    end
  end

  context 'when the given block returns truthy' do
    it 'just passes' do
      expect {
        '0'.class != '3'.to_i.times.map {|i| i + 1 }.class
      }.to be_assert
    end
  end

  context 'when given other objects, will be similar as a be_truthy behavior' do
    it 'passes if truthy' do
      expect(true).to be_assert
      expect(0).to be_assert
      expect('').to be_assert
      expect('false').to be_assert
    end

    it 'fails if falsy' do
      expect(nil).to be_assert
    end
  end

  context 'with some rspec features - e.g: subject/let' do
    let(:result) { [5, -1, 43] }
    subject { [4.2, -4/2r, 42] }

    context 'when the given block returns falsy' do
      it 'shows power_assert inspection' do
        expect {
          subject.map(&:to_i).map(&:succ) == result.reverse
        }.to be_assert
      end
    end

    context 'when the given block returns truthy' do
      it 'just passes' do
        expect {
          subject.map(&:to_i).map(&:succ) == result
        }.to be_assert
      end
    end
  end
end
