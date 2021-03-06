$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/options/version'
version = Lab42::Options::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_options'
  s.version     = version
  s.summary     = "Command Lines the Ruby Way"
  s.description = %{Specify command line arguments with Ruby Syntax}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = "https://github.com/RobertDober/lab42_options"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'lab42_core', '~> 0.0.7'
  s.add_dependency 'forwarder2', '~> 0.2.0'
  s.add_development_dependency 'pry', '~> 0.9'
  s.add_development_dependency 'pry-nav', '~> 0.2'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'qed', '~> 2.9'
  s.add_development_dependency 'ae', '~> 1.8'
  s.add_development_dependency 'byebug', '~> 3.1'
  s.add_development_dependency 'mocha', '~> 1.1'
  s.add_development_dependency 'test-unit', '~> 2.1'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.0'

end
