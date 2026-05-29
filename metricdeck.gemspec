# frozen_string_literal: true

require_relative 'lib/metricdeck/version'

Gem::Specification.new do |spec|
  spec.name = 'metricdeck'
  spec.version = Metricdeck::VERSION
  spec.authors = ['Athar Team']
  spec.email = ['info@athar.com']

  spec.summary = 'Pluggable metric card framework for Rails'
  spec.description = 'A calculator registry that produces standardized metric cards with trends, ' \
                     'comparisons, and i18n labels.'
  spec.homepage = 'https://github.com/athar/metricdeck'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.4.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/shqear93/metricdeck'
  spec.metadata['changelog_uri'] = 'https://github.com/shqear93/metricdeck/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.glob('{lib,generators}/**/*') + %w[LICENSE.txt Rakefile README.md CHANGELOG.md]
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 7.0', '< 9.0'
end
