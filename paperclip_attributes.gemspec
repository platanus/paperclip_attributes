$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "paperclip_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "paperclip_attributes"
  s.version     = PaperclipAttributes::VERSION
  s.authors     = ["Platanus", "Leandro Segovia"]
  s.email       = ["rubygems@platan.us", "ldlsegovia@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of PaperclipAttributes."
  s.description = "TODO: Description of PaperclipAttributes."
  s.license     = "MIT"

  s.files = `git ls-files`.split($/).reject { |fn| fn.start_with? "spec" }
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"

  s.add_development_dependency "pry"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.4.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.6.0"
end
