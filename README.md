# [![Sean Huber](https://cloud.githubusercontent.com/assets/2419/6550752/832d9a64-c5ea-11e4-9717-6f9aa6e023b5.png)](https://github.com/shuber) variables

[![Build Status](https://secure.travis-ci.org/shuber/variables.svg)](http://travis-ci.org/shuber/variables) [![Code Climate](https://codeclimate.com/github/shuber/variables/badges/gpa.svg)](https://codeclimate.com/github/shuber/variables) [![Coverage](https://codeclimate.com/github/shuber/variables/badges/coverage.svg)](https://codeclimate.com/github/shuber/variables)

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

name = user.instance_variable(:name)
undefined = user.instance_variable(:undefined)

name.get      #=> "Bob"
undefined.get #=> nil

name.defined?      #=> true
undefined.defined? #=> false

name.fetch      #=> "Bob"
undefined.fetch #=> Variables::UndefinedVariable - undefined variable "undefined"

name.fetch(:default)      #=> "Bob"
undefined.fetch(:default) #=> :default

name.fetch { :default }                      #=> "Bob"
undefined.fetch { |name| "#{name}-default" } #=> "@undefined-default"
```

You can do the same thing for class variables with `SomeClass.class_variable(:whatever)`.


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
