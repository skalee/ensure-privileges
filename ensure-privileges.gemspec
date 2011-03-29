# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ensure-privileges/version"

Gem::Specification.new do |s|
  s.name        = "ensure-privileges"
  s.version     = Ensure::Privileges::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sebastian Skalacki"]
  s.email       = ["skalee@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Easy way to test authorization features of your controllers with RSpec.}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "ensure-privileges"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
