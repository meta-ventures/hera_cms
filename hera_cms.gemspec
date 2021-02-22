$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "hera_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "hera_cms"
  spec.version       = HeraCms::VERSION
  spec.summary       = "Turn your rails application into a Content Managing Site (CMS)"
  spec.homepage      = "https://github.com/horta-tech/hera_cms"
  spec.license       = "MIT"

  spec.authors       = ["Rayan Castro"]
  spec.email         = ["rayancdc@gmail.com"]

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = 'http://rubygems.org'
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"
  spec.add_dependency "yaml", "~> 0.1.1", ">= 0.1.1"

  spec.add_development_dependency "pg", "~> 1.2.3", ">= 1.2.3"
  spec.add_development_dependency 'rspec-rails', "~> 4.0.2", ">= 4.0.2"
  spec.add_development_dependency 'factory_bot_rails', "~> 6.1.0", ">= 6.1.0"
  spec.add_development_dependency 'byebug', "~> 11.1.3", ">= 11.1.3"
end


# $ gem bump --version minor # bumps to the next minor version
# $ gem bump --version major # bumps to the next major version
# $ gem bump --version 1.1.1 # bumps to the specified version 

# gem build hera_cms.gemspec
# gem push