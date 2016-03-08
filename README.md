# NdrUi [![Build Status](https://travis-ci.org/PublicHealthEngland/ndr_ui.svg)](https://travis-ci.org/PublicHealthEngland/ndr_ui)

This is the Public Health England (PHE) National Disease Registration (NDR) User Interface rubygem,
providing:

1. jQuery
2. [Bootstrap](http://getbootstrap.com)
3. a Bootstrap based Rails Form Builder
4. ~~Bootstrap based pagination links~~
5. Bootstrap based Rails Helpers
6. Bootstrap based date picker

To experiment with the code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ndr_ui'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ndr_ui

## Usage

Require NdrUi javascripts at the top of `app/assets/javascripts/application.js`:

```javascript
//= require ndr_ui
```

Import NdrUi styles at the top of `app/assets/stylesheets/application.scss`:

```scss
/*
*= require ndr_ui
*/
```

### Date Picker

To use the date picker, require it after ndr_ui. For example:

In `app/assets/javascripts/application.js`:

```javascript
//= require ndr_ui
//= require ndr_ui/datepicker
```

In `app/assets/stylesheets/application.scss`:

```scss
/*
*= require ndr_ui
*= require ndr_ui/datepicker
*/
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PublicHealthEngland/ndr_ui.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

