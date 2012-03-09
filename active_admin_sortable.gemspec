$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin_sortable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin_sortable"
  s.version     = ActiveAdminSortable::VERSION
  s.authors     = ["Bruno Bornsztein"]
  s.email       = ["bruno@curbly.com"]
  s.summary     = %q{Extends ActiveAdmin to provide a page on which to sort a model's instances.'}
  s.description = %q{Extends ActiveAdmin to provide a page on which to sort a model's instances.}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0.beta"
  s.add_dependency 'activeadmin'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
