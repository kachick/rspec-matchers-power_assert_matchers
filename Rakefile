# frozen_string_literal: true

require 'bundler/gem_tasks'

# refs:
#   * https://relishapp.com/rspec/rspec-core/v/3-10/docs/command-line/rake-task
#   * https://github.com/rspec/rspec-core/blob/ea8554afd1a2b63677c6593059fa8f2476181deb/lib/rspec/core/rake_task.rb
#   * https://github.com/rspec/rspec-core/blob/ea8554afd1a2b63677c6593059fa8f2476181deb/spec/rspec/core/rake_task_spec.rb
require 'rspec/core/rake_task'

require 'irb/color'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = %w[-w]
end

task :look_at_examples do
  puts IRB::Color.colorize_code(File.read('./examples/spec/example_spec.rb'))
end

RSpec::Core::RakeTask.new(:run_examples) do |t|
  t.pattern = 'examples/**{,/*/**}/*_spec.rb'
end

task default: [:spec]

begin
  require 'rubocop/rake_task'
rescue LoadError
  puts 'can not use rubocop in this environment'
else
  RuboCop::RakeTask.new
end

task(:view_packaging_files) do
  sh('rm -rf ./pkg')
  sh('rake build')
  cd('pkg') do
    sh('gem unpack *.gem')
    sh('tree -I *\.gem')
  end
  sh('rm -rf ./pkg')
end

task(:update) do
  sh('dprint config update --yes')
end

desc 'Print dependencies'
task :deps do
  sh('ruby --version')
  sh('dprint --version')
  sh('tree --version')
  sh('typos --version')
end

desc 'Tests except ruby'
task :linters do
  sh('typos . .github .vscode')
  sh('dprint check')
  sh('nixfmt --check ./*.nix')
end

desc 'https://github.com/kachick/selfup'
task :selfup do
  sh('git ls-files | xargs nix run github:kachick/selfup/v1.2.0#selfup -- run')
end
