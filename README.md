# Rides

Welcome to rides! This gem hopes to make it easier for anyone coordinating rides to set rides up. This gem will take an input of drivers and riders, along with their location, and assign riders to drivers based on their distance. This gem was mainly designed to help out my personal organization because it was a huge headache, but perhaps it will solve the issue for others as well! Enjoy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rides'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rides

## Usage

In order to add a new rider or driver, execute: 

```ruby
rides add "Nathan Shin"
```

It will prompt you through a series of questions and will add the person to the database.

If you would like to remove a rider or driver, simply use: 

```ruby
rides remove "Nathan Shin"
```

No need to deal with SQL with this application.

Want a list of everyone on the drivers of riders lists? Execute: 

```ruby
rides list
```

Finally, and arguably the most important of all, arrange rides with a couple keystrokes and a click of a button:

```ruby
rides arrange
```

Hope this gem will make your life a little bit easier!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nathanshin/rides.

