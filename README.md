# [![Sean Huber](https://cloud.githubusercontent.com/assets/2419/6550752/832d9a64-c5ea-11e4-9717-6f9aa6e023b5.png)](https://github.com/shuber) variables

[![Build Status](https://secure.travis-ci.org/shuber/eigenclass.png)](http://travis-ci.org/shuber/eigenclass) [![Code Climate](https://codeclimate.com/github/shuber/eigenclass/badges/gpa.svg)](https://codeclimate.com/github/shuber/eigenclass) [![Coverage](https://codeclimate.com/github/shuber/eigenclass/badges/coverage.svg)](https://codeclimate.com/github/shuber/eigenclass)

> Ruby already has `Method` objects, why not `Variable` objects as well?


## Installation

```
gem install variables
```


## Requirements

Ruby 1.8.7+


## Usage

```ruby
user = User.find_by_name("Bob")

user.instance_variable(:name).get      #=> "Bob"
user.instance_variable(:undefined).get #=> nil

user.instance_variable(:name).defined?      #=> true
user.instance_variable(:undefined).defined? #=> false

user.instance_variable(:name).fetch      #=> "Bob"
user.instance_variable(:undefined).fetch #=> Variables::UndefinedVariable - undefined variable "undefined"

user.instance_variable(:name).fetch(:default)      #=> "Bob"
user.instance_variable(:undefined).fetch(:default) #=> :default
```


## Testing

```
bundle exec rspec
```


## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## License

[MIT](https://github.com/shuber/variables/blob/master/LICENSE)  - Copyright © 2015 Sean Huber
