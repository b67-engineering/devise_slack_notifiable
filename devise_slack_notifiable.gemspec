# frozen_string_literal: true

require_relative 'lib/devise_slack_notifiable/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_slack_notifiable'
  spec.version       = DeviseSlackNotifiable::VERSION
  spec.authors       = ['whitemerry']
  spec.email         = ['whitemerry@outlook.com']

  spec.summary       = 'Devise slack notifactions gem'
  # spec.description   = 'TODO: Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/invoicity/devise_slack_notifiable'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/invoicity/devise_slack_notifiable'
  spec.metadata['changelog_uri'] = 'https://github.com/invoicity/devise_slack_notifiable/releases'

  spec.add_dependency 'rails'
  spec.add_dependency 'devise'
  spec.add_dependency 'slack-notifier'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
