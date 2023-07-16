# rspec-matchers-power_assert_matchers

[![Build Status](https://github.com/kachick/rspec-matchers-power_assert_matchers/actions/workflows/spec.yml/badge.svg?branch=main)](https://github.com/kachick/rspec-matchers-power_assert_matchers/actions/workflows/spec.yml?query=branch%3Amain+)
[![Gem Version](https://badge.fury.io/rb/rspec-matchers-power_assert_matchers.svg)](https://badge.fury.io/rb/rspec-matchers-power_assert_matchers)

## Overview

![screenshot1](https://user-images.githubusercontent.com/1180335/118840923-c9b3a980-b902-11eb-8c8c-afb17fa87d31.png)
![screenshot2](https://user-images.githubusercontent.com/1180335/118840930-cb7d6d00-b902-11eb-8d8e-f6fcdc801367.png)

[ruby/power_assert](https://github.com/ruby/power_assert) integration for RSpec.

No monkey patching exists.\
Just using [RSpec's Custom matchers way](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/custom-matchers).\
I hope this might be a choice to integrate `PowerAssert` in RSpec.

## Usage

Require following dependencies

- Ruby 3.1 or higher # Tested only in the head and last 2 rubies
- [rspec](https://rubygems.org/gems/rspec/)
- [power_assert](https://rubygems.org/gems/power_assert)
- [irb](https://rubygems.org/gems/irb) # To colorize

See [gemspec](rspec-matchers-power_assert_matchers.gemspec) for detail of the version restriction.

Add below code into your `library`'s gemspec

```ruby
Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec-matchers-power_assert_matchers', '~> 0.2.0'
end
```

Or add below into your `application`'s `Gemfile`

```ruby
group :test do
  gem 'rspec-matchers-power_assert_matchers', '~> 0.2.0'
end
```

So adding this into your `spec_helper.rb` or `rails_helper.rb`

```ruby
require 'rspec/matchers/power_assert_matchers'
```

Then you can use `power_assert` with a simple custom matcher in rspec.

Use `expect` with block, and use `be_assert` matcher.

```ruby
RSpec.describe RSpec::Matchers::PowerAssertMatchers do
  context 'when the given block returns falsy' do
    it 'shows power_assert inspection' do
      expect {
        '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
      }.to be_assert
    end
  end
end
```

```text
  1) RSpec::Matchers::PowerAssertMatchers when the given block returns falsy shows power_assert inspection
     Failure/Error:
       expect {
         '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
       }.to be_assert

               '0'.class == '3'.to_i.times.map {|i| i + 1 }.class
                   |     |      |    |     |                |
                   |     |      |    |     |                Array
                   |     |      |    |     [1, 2, 3]
                   |     |      |    #<Enumerator: ...>
                   |     |      3
                   |     false
                   String
    # ./examples/spec/example_spec.rb:6:in `block (3 levels) in <top (required)>'
```

If you want to easy to check the behavior, this repository has example specs.

```console
$ git clone git@github.com:kachick/rspec-matchers-power_assert_matchers.git
$ cd rspec-matchers-power_assert_matchers
$ bundle install
$ bundle exec rake look_at_examples
Rough examples will be shown!
$ bundle exec rake run_examples
Some results will be shown!
```

## NOTE

- Currently the matcher is named `be_assert`. I don't have confident it is good or not.
- Extending built-in `be_truthy` sounds good for considering the role, but I would not like to add monkey patching for built-in features...

## References

- [power-assert-js/power-assert](https://github.com/power-assert-js/power-assert)
- [Power Assert in Ruby](https://speakerdeck.com/k_tsj/power-assert-in-ruby)
- [Another way of power_assert in rspec - joker1007/rspec-power_assert](https://github.com/joker1007/rspec-power_assert)
