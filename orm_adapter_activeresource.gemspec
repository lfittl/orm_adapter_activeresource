$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "orm_adapter_activeresource"
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Lukas Fittl"]
  s.description = "Extends orm_adapter with support for ActiveResource"
  s.summary = "Extends the orm_adapter ORM abstraction layer with support for Rails' ActiveResource REST-based ORM."
  s.email = "lukas@fittl.com"
  s.homepage = "http://github.com/lfittl/orm_adapter_activeresource"
  
  s.rubyforge_project = "orm_adapter_activeresource"
  s.required_rubygems_version = ">= 1.3.6"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_development_dependency "orm_adapter", ">= 0.0.7"
end