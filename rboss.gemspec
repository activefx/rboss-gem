Gem::Specification.new do |s|
  s.name = %q{rboss}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joseph Wilk"]
  s.date = %q{2008-09-13}
  s.description = %q{Api wrapping Yahoo Boss search}
  s.email = ["joe@eshopworks.co.uk"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/eshopworks/rboss-gem}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rboss}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Api wrapping Yahoo Boss search}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<json_pure>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.1.4"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<json_pure>, [">= 1.1.3"])
      s.add_dependency(%q<rspec>, [">= 1.1.4"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<json_pure>, [">= 1.1.3"])
    s.add_dependency(%q<rspec>, [">= 1.1.4"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
