# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sailthru-client}
  s.version = "1.06"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Prajwal Tuladhar"]
  s.date = %q{2011-04-08}
  s.email = %q{praj@sailthru.com}
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "lib/sailthru.rb"]
  s.homepage = %q{http://docs.sailthru.com}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{A simple client library to remotely access the Sailthru REST API.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end
