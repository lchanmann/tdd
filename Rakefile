require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :autotest do
  exec "infinity_test --rspec"
end
