# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{matchable}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Friedgan"]
  s.date = %q{2009-05-11}
  s.default_executable = %q{}

  s.executables = []
  s.files = [
    "Rakefile",
    "VERSION.yml",
    "lib/matchable.rb",
    "test/matchable.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://hubrix.github.com/matchable/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{ML Style method and case statement matching}
  s.test_files = [
    "test/matchable.rb",
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
