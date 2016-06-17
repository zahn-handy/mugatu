# Mugatu

Mugatu is a command line utility that runs linters. Instead of linting your
entire repository, mugatu uses git to figure out which files changed, then lints
only those files, then reports to you only the errors it finds in the lines you
changed.

This tool will be most useful for legacy codebases. Now you can relax and let
mugatu keep your codebase really goodlooking.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mugatu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mugatu


## Usage

Running `mugatu --help` on the command line will print out an example config
file for a Ruby project to be linted by Rubocop. This config file should be
placed at the root of your project directory.

After creating that file, you can run `mugatu`. This will run all configured
linters.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/zahn-handy/mugatu.


## License

Closed source. All rights reserved.

