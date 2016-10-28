# LogQuery

TODO: Add description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_query'
```

And then execute:

    $ bundle

Or install the binary as:

    $ gem install log_query

## Usage

`heroku logs --tail -n 1500 | lq --group_by path --measure service --average --varience --percentile 99`

![log_query usage](/log_query.gif?raw=true)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/log_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

