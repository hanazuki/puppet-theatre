# PuppetTheatre

PuppetTheatre is an integration framework for configuration management, infrastructure testing and monitoring.
It runs several checks and tests on a set of servers and generates a report for a quick overview how well the servers are configured.

## Configuration

Configuration is written as a Ruby script with PuppetTheatre DSL. See `example/example.rb` in this repository for an example.

You can configure four kinds of pluggable components: a host generator, checkers, reporters, notifiers.

- A host generator fetches list of available hosts.
- A checker runs a set of tests or checks which evaluates the status of each host and returns a result.
- A reporter generates a report for humans from the results from the checkers for all the hosts.
- A notifier sends a notification for a new report through a configured channel.

## Components

### Host generators
#### array

```ruby
c.hosts_from :array, hosts: %w[host1.example.com host2.example.com]
```

Returns a list of hosts from an array.

#### getent

```ruby
c.hosts_from :getent, pattern: /\.lan\z/
```

Returns a list of hosts available in the result of `getent hosts`, which is usually read from `/etc/hosts` file.

#### mackerel

```ruby
c.hosts_from :mackerel, api_key: 'XXXYYYZZZ', service: 'your-awesome-service'
```

Returns a list of hosts registred to [Mackerel](https://mackerel.io). Requires `mackerel-rb` gem.

### Checkers
#### console

```ruby
c.add_checker :console
```

Prints the name of each host to the standard output. This is a dummy checker that returns no result for the host and can be used to check the progress of running checks.

#### puppet\_noop

```ruby
c.add_checker :puppet_noop
```

Runs [Puppet](https://puppetlabs.com/puppet) on each host and checks that the configuration of the host is in sync with the Puppet manifest.
Currently only agent-less configuration with master server is supported and SSH access to the hosts is required.

#### rspec

```ruby
c.add_checker :rspec,
              bundler: '/usr/local/bin/bundle',
              workdir: '/path/to/your/specs'
              args: {'pattern' => 'spec/**/*_spec.rb'},
              env: {'ENV_NAME' => 'value'}
```

Run [Rspec](http://rspec.info). You can use any Rspec extensions including [Serverspec](http://serverspec.org/).

### Reporters
#### console

```ruby
c.add_reporter :console
```

Dumps the check results to the standard output.

#### summary

```ruby
c.add_reporter :summary
```

Notifies a summary of the check results.

#### html

```ruby
c.add_reporter :html, path: '/var/www/html', uri: 'https://ops.example.com/'
```

Generates a HTML report at the specified directory, which is expected to be served by a web server.
URI to the report will be notified (for example, `https://ops.example.com/20160102T030405.html`)

### Notifiers
#### console

```ruby
c.add_notifier :console
```

Writes any notification to the standard output.

#### takosan

```ruby
c.add_notifier :takosan,
               url: 'https://takosan.example.com/',
               channel: '#ops',
               name: 'puppet theatre',
               icon: ':innocent:'
```

Sends notifications to a [Takosan](https://github.com/kentaro/takosan) server, a web-to-Slack gateway. Requires `takosan` gem.

### Multi-Process

```ruby
c.in_processes 3
```

You can specify the number of active processes.

### Custom Components

You can create a custom component by defining a class in the corresponding modules (`PuppetTheatre::Hosts`, `PuppetTheatre::Checkers`, `PuppetTheatre::Reporters` and `PuppetTheatre::Notifiers`).
