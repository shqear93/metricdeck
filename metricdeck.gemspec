# frozen_string_literal: true

require_relative 'lib/metricdeck/version'

Gem::Specification.new do |spec|
  spec.name = 'metricdeck'
  spec.version = Metricdeck::VERSION
  spec.authors = ['Athar Team']
  spec.email = ['info@athar.com']

  spec.summary = 'Pluggable metric card framework for Rails'
  spec.description = 'A calculator registry that produces standardized metric cards with trends, comparisons, and i18n labels.'
  spec.homepage = 'https://github.com/athar/metricdeck'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/athar-association'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/athar-association/athar-ems'
  spec.metadata['changelog_uri'] = 'https://github.com/athar-association/athar-ems/blob/main/gems/metricdeck/CHANGELOG.md'
  spec.metadata['github_repo'] = 'ssh://github.com/athar-association/athar-ems'

  spec.files = Dir.glob('{lib,generators}/**/*') + %w[LICENSE.txt Rakefile README.md CHANGELOG.md]
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 7.0'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
