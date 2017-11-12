# Tamashii::Config

Abstract configurable object for tamashii

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tamashii-config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tamashii-config

## Usage

### Global Config

```ruby
Tamashii::Config.add :name
Tamashii::Config.name = 'Tamashii'
```

```ruby
Tamashii::Config.register :agent, Tamashii::Agent.config
Tamashii::Config.agent.name # => "Agent Name"
```

### Type Check

```ruby
Tamashii::Config.add :name, as: String
Tamashii::Config.name = 1 # raise Tamashii::Config::Attribute::TypeMismatchError
```

### Configurable

```ruby
class AgentConfig
  include Tamashii::Configurable

  config :server, as: String
  config :port, as: Integer
end

config = AgentConfig.new
config.server = 'wss://tamashii.io'
config.port = 443
```

### Delegate

```ruby
class AgentConfig
  include Tamashii::Configurable

  # Hash object is allowed
  config :token, to: Tamashii::Config
end

config = AgentConfig.new
config.token # => Tamashii::Config.token
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tamashii-config.
