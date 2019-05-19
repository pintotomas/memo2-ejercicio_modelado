require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format d'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
  task.requires << 'rubocop-rspec'
end

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber) do |t|
  t.profile = 'cucumber_profile'
end

task default: %i[spec rubocop cucumber]
