# workdey

Workdey helps people find simple tasks that they can do and earn cash.

[Live application](http://workdey.herokuapp.com)

## Getting Started

To run this application locally, all you need to do is to either fork/clone this repository or you can download the entire repository as a zip file.

## Dependencies

The application runs on the ruby powered rails framework. Make sure you have the following installed on your local machine:

* [Install Ruby](http://www.ruby-lang.org)
* [Install Rails](http://rubyonrails.org)
* [Install RubyGems](https://rubygems.org/pages/download)
* [Install Bundler](http://bundler.io/)

After installing, run `bundle install` to install all the application dependencies.

## Database setup

Run the following command from the terminal:

```shell
$ rake db:setup
```

Create the database for the test environment as well:

```shell
$ rake db:setup RAILS_ENV=test
```

## Running the tests

Run the following command from the terminal to get all tests running

```shell
$ rspec spec
```

## Setting up the server

Run the following command to start the server

```shell
$ rails server
```

## Contributing

1. Fork it: [Fork workdey on Github](https://github.com/andela/workdey/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
