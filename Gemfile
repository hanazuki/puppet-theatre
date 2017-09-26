source 'https://rubygems.org'

gemspec

# for CentOS 7
if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.1.0')
  gem 'sshkit', '1.9.0'
  gem 'parallel', '1.10.0'
else
  gem 'sshkit'
  gem 'parallel'
end

group :test do
  gem 'takosan', '~> 1.1.0'

  if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.2')
    gem 'activesupport', '>= 4.0.0', '< 5.0.0'
  end
end
