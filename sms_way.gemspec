# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: sms_way 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sms_way"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Edson de Lima"]
  s.date = "2014-11-27"
  s.description = "sms_way helps you to send SMS, WAP or MMS messages trough of apis of gateways as Kannel, UseSMS or others."
  s.email = "edsonalima@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "config/sms_way.yml",
    "lib/config.rb",
    "lib/sms_way.rb",
    "lib/sms_way/base.rb",
    "lib/sms_way/registry.rb",
    "spec/base_spec.rb",
    "spec/config_spec.rb",
    "spec/dummy/config/sms_way.yml",
    "spec/dummy/lib/sms_way/kannel.rb",
    "spec/dummy/lib/sms_way/use_sms.rb",
    "spec/dummy/test_registry.rb",
    "spec/registry_spec.rb",
    "spec/sms_way_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/edsonlima/sms_way"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.3"
  s.summary = "Easy way to send SMS messages through any gateway."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<api_smith>, [">= 0"])
      s.add_runtime_dependency(%q<settingslogic>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<api_smith>, [">= 0"])
      s.add_dependency(%q<settingslogic>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<api_smith>, [">= 0"])
    s.add_dependency(%q<settingslogic>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

