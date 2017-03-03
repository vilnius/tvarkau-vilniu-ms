# Tvarkau Vilnių backend

[![Build Status](https://travis-ci.org/vilnius/tvarkau-vilniu-ms.svg)](https://travis-ci.org/vilnius/tvarkau-vilniu-ms)
[![Join us on Slack](https://img.shields.io/badge/slack-codeforvilnius%20%23tvarkau--vilniu-blue.svg)](https://codeforvilnius.slack.com)

Backend of Tvarkau Vilnių apps. Manages problems reported by Vilnius citizens.

## Getting started

### Environment setup (OSX)

- Setup [Homebew](https://brew.sh/)
- Using `brew`, setup `rbenv`: [Guide](https://github.com/rbenv/rbenv#homebrew-on-mac-os-x)
- Using `rbenv`, setup `Rails 2.3.1`
- Using `brew`, setup `PostgreSQL`: [Guide](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/)
- In project directory, run `bundle install` 

### Running app

- Ensure database migrations are up to date
    - If this is your first run: `rake db:setup` then `rake db:migrate` then `rake db:seed`
    - Every other time `rake db:migrate`
- Start server using `rails s`
- Open `localhost:3000/api/reports` to get latest reports

### Running tests

- `bundle exec rspec spec`

## Related projects:

- Android: https://github.com/vilnius/tvarkau-vilniu
- iOS: https://github.com/vilnius/tvarkau-vilniu-ios

## Contribute

- Join us on Slack `#tvarkau-vilniu`! For an automated invitation click the big Slack button at http://codeforvilnius.lt
- Feel free to create pull requests or issues
- Contribution guide coming soon

**Note: This is a work in-progress**

