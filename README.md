# Tvarkau Vilnių backend

[![Build Status](https://travis-ci.org/vilnius/tvarkau-vilniu-ms.svg)](https://travis-ci.org/vilnius/tvarkau-vilniu-ms)
[![Join us on Slack](http://c4v.herokuapp.com/badge.svg)](http://c4v.herokuapp.com/)

API for Tvarkau Vilnių apps. Manages problems reported by Vilnius citizens.

## Getting started

### Running app (using docker)

```
$ docker-compose up
```

### Running app (using native ruby)

Pre-requisites:

- Install [Homebrew](https://brew.sh/)
- Install [rbenv](https://github.com/rbenv/rbenv#homebrew-on-mac-os-x) 
- Install [rails 2.3.1](https://gorails.com/setup/osx/10.12-sierra) 
- Run DB `docker-compose up -d db`
- `bundle install`
- Ensure database migrations are up to date
    - If this is your first run: `rake db:setup`, `rake db:seed`
    - Every other time `rake db:migrate`
- Start server using `rails s`

Open `http://localhost:3000/api/reports` to get latest reports

### Running tests

- `bundle exec rspec spec` or `./run-tests-in-docker.sh`

## Related projects:

- Android: https://github.com/vilnius/tvarkau-vilniu
- iOS: https://github.com/vilnius/tvarkau-vilniu-ios

## Contribute

- Join us on Slack `#tvarkau-vilniu`! For an automated invitation click the big Slack button at http://codeforvilnius.lt
- Feel free to create pull requests or issues
- Contribution guide coming soon
- Check out for more at http://codeforvilnius.lt/

**Note: This is a work in-progress**
