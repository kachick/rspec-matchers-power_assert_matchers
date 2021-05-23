# coding: us-ascii
# frozen_string_literal: true

lib_name = 'rspec-matchers-power_assert_matchers'

require_relative './lib/rspec/matchers/power_assert_matchers/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  gem.summary       = %q{`power_assert in rspec` as a pure custom matcher}
  gem.description   = gem.summary
  gem.homepage      = repository_url
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = RSpec::Matchers::PowerAssertMatchers::VERSION

  gem.metadata = {
    'homepage_uri'      => repository_url,
    'source_code_uri'   => repository_url,
  }

  gem.add_runtime_dependency 'rspec', '>= 3.5.0', '< 4.0'
  gem.add_runtime_dependency 'power_assert', '>= 2.0.0', '< 3.0'
  gem.add_runtime_dependency 'irb', '>= 1.3.5', '< 2.0'

  gem.add_development_dependency 'rspec', '>= 3.10.0', '< 4.0'
  gem.add_development_dependency 'warning', '>= 1.2.0', '< 2.0'
  gem.add_development_dependency 'rake', '>= 13.0.3', '< 20.0'
  gem.add_development_dependency 'rubocop', '>= 1.14.0', '< 1.15.0'
  gem.add_development_dependency 'rubocop-rake'
  gem.add_development_dependency 'rubocop-performance'
  gem.add_development_dependency 'rubocop-rubycw'
  gem.add_development_dependency 'rubocop-rspec'

  gem.required_ruby_version = '>= 2.5.0'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  git_ls_filepaths = `git ls-files`.lines.map(&:chomp)
  minimum_filepaths = git_ls_filepaths.grep(%r!\A(?:lib|sig)/!)
  raise "obvious mistaken in packaging files: #{minimum_filepaths.inspect}" if minimum_filepaths.size < 2
  extra_filepaths = %w[README.md LICENSE.txt]
  raise 'git ignores extra filename' unless (extra_filepaths - git_ls_filepaths).empty?
  gem.files         = minimum_filepaths | extra_filepaths
  gem.require_paths = ['lib']
end
