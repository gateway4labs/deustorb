# DeustoRB

## Please don't use this. Yet.

DeustoRB is a simple client for the WebLab Deusto remote laboratory platform.

Based on the Python version.

[![Build Status](https://secure.travis-ci.org/lms4labs/deustorb.png)](http://travis-ci.org/lms4labs/deustorb)

## Installation

Add this line to your application's Gemfile:

    gem 'deustorb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deustorb

## Usage

```ruby
  client = Deustorb::Client.new('weblab.deusto.server.url.com')

  client.login('username', 'password') # => {"result"=>{"id"=>"some-sesion-id"}, "is_exception"=>false}

  client.list_experiments # => huge hash with experiments
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
