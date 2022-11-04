# coding: us-ascii
# frozen_string_literal: true

lib_name = 'rspec-matchers-power_assert_matchers'

require_relative './lib/rspec/matchers/power_assert_matchers/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  gem.summary       = %q{`power_assert in rspec` as a pure custom matcher}
  gem.description   = %q{"ruby/power_assert" integration for RSpec. No monkey patching exists.}
  gem.homepage      = repository_url
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = RSpec::Matchers::PowerAssertMatchers::VERSION

  gem.metadata = {
    'homepage_uri'          => repository_url,
    'source_code_uri'       => repository_url,
    'bug_tracker_uri'       => "#{repository_url}/issues",
    'rubygems_mfa_required' => 'true'
  }

  gem.add_runtime_dependency('rspec', '>= 3.5.0', '< 4.0')
  gem.add_runtime_dependency('power_assert', '>= 2.0.0', '< 3.0')
  gem.add_runtime_dependency('irb', '>= 1.4.0', '< 2.0') # To colorize

  gem.required_ruby_version = '>= 2.7.2'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  might_be_parsing_by_tool_as_dependabot = `git ls-files`.lines.empty?
  files = Dir['README*', '*LICENSE*',  'lib/**/*', 'sig/**/*'].uniq
  if !might_be_parsing_by_tool_as_dependabot && files.grep(%r!\A(?:lib|sig)/!).size < 4
    raise "obvious mistaken in packaging files: #{files.inspect}"
  end
  gem.files         = files
  gem.require_paths = ['lib']
end
