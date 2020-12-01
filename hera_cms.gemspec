require_relative 'lib/hera_cms/version'

Gem::Specification.new do |spec|
  spec.name          = "hera_cms"
  spec.version       = HeraCms::VERSION
  spec.summary       = "Turn your rails application into a Content Managing Site (CMS)"
  spec.homepage      = "https://github.com/horta-tech/hera_cms"
  spec.license       = "MIT"

  spec.authors       = ["Rayan Castro"]
  spec.email         = ["rayancdc@gmail.com"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 5"
  spec.add_dependency "activerecord", ">= 5"
end
