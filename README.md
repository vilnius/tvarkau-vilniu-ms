# README #

### What is this repository for? ###

* This repository is to develop 
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###
#### Environment for mac users
* Setup [Homebew](https://brew.sh/)
* Using `brew` setup [rbenv](https://github.com/rbenv/rbenv#homebrew-on-mac-os-x)
* Using `rbenv` setup Rails 2.3.1
* Using `brew` setup PostgreSQL. [Here](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/) is a good guide how to do that.
* Go to place where you cloned the project and run `bundle install`

#### Starting the app
* Ensure database migrations are up to date. 
    * If this is your first run: `rake db:setup` then `rake db:migrate` then `rake db:seeed`.
    * Every other time `rake db:migrate`
* Start server using `rails s`
* Go to for example `localhost:3000/api/reports` to get latest reports

#### Run specs
* Run tests using `bundle exec rspec spec`

### Contribution guidelines ###

* Every class must have a spec.

### Who do I talk to? ###

* TODO