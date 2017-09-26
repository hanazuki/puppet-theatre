source 'https://rubygems.org'

gemspec

group :test do
  gem 'takosan', '~> 1.1.0'

  if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.2')
    gem 'activesupport', '>= 4.0.0', '< 5.0.0'
  end
end
