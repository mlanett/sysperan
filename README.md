# Sysperan

Helps with system performance analysis by making it easy to generate start and finish events,
which can then be processed separately.

## Installation

Add this line to your application's Gemfile:

    gem 'sysperan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sysperan

## Usage

In your app, create an instance of Sysperan::Client and wrap your code to measure in

client.perform do
  ...
end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
