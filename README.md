# DucksboardReporter

Ducksnoard is a cool dashboard as a service like geckoboard but looks nicer. This project can be seen as a infrastructure for and a collection of reporters that report values to ducksboard. In a way reporters are similar to nagios agents, but for generation pokemon. Surely it could turn into a more abstract reporter framework that can report to geckoboard, nagios, whatever aswell. Right now we use ducksboard, so it is for ducksboard.

## Installation

Add this line to your application's Gemfile:

    gem 'ducksboard_reporter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ducksboard_reporter

## Usage

To run your reporters just launch it via
	
	ducksboard_reporter -f /your/config_file.yml

See example_config.yml for in about the format etc.

To run in a production environment you could wrap in into a daemon and let it be managed by the init system du jour.

You can build new reporters by inheriting from DucksboardReporter::Reporters::Reporter and implement your own #collect method which must set @value. See existing reporters for examples.

## Changelog

* bumped version number to 0.2.0 since it now has mysql reporters

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ducksboard_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
