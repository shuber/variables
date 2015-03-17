# [![Sean Huber](https://cloud.githubusercontent.com/assets/2419/6550752/832d9a64-c5ea-11e4-9717-6f9aa6e023b5.png)](https://github.com/shuber) variables

[![Build Status](https://secure.travis-ci.org/shuber/variables.svg)](http://travis-ci.org/shuber/variables) [![Code Climate](https://codeclimate.com/github/shuber/variables/badges/gpa.svg)](https://codeclimate.com/github/shuber/variables) [![Coverage](https://codeclimate.com/github/shuber/variables/badges/coverage.svg)](https://codeclimate.com/github/shuber/variables) [![Gem Version](https://badge.fury.io/rb/variables.svg)](http://badge.fury.io/rb/variables)

> `Variable` objects for *class* and *instance* variables

Ruby already has `Method` objects, why not `Variable` objects as well?

## Why?

Some methods already exist for interacting with *class* and *instance* variables:

* `Module#class_variable_defined?`
* `Module#class_variable_get`
* `Module#class_variable_set`
* `Object#instance_variable_defined?`
* `Object#instance_variable_get`
* `Object#instance_variable_set`

But notice that these all share a common prefix - `instance_variable_` or `class_variable_`.

This feels a little [smelly](http://en.wikipedia.org/wiki/Code_smell), let's try to [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) it up with some `Variable` objects!


## Installation

```
gem install variables
```


## Requirements

Ruby 1.8.7+


## Usage

Let's experiment with a simple `User` class.

```ruby
class User
  def initialize(name)
    @name = name
  end
end
```

Objects can have any number of *instance* variables. 

```ruby
user = User.new('Bob')              #=> #<User:0x007f8f6a84aa98>
user.instance_variable_get('@name') #=> "Bob"
```

Similar to [`Object#method`](http://ruby-doc.org/core-1.8.7/Object.html#method-i-method), the `instance_variable` method returns a `Variable` object.

```ruby
name = user.instance_variable(:name) #=> #<InstanceVariable: #<User>@name>
```

But unlike `Object#method`, this method does not require a variable to actually be defined.

```ruby
undefined = user.instance_variable(:undefined) #=> #<InstanceVariable: #<User>@undefined>
```

We can check if a variable is defined by using the `defined?` method.

```ruby
name.defined?      #=> true
undefined.defined? #=> false
```

Once we have a `Variable` object, we can `get` its value.

```ruby
name.get      #=> "Bob"
undefined.get #=> nil
```

Similar to [`Hash#fetch`](http://ruby-doc.org/core-1.9.3/Hash.html#method-i-fetch), the `fetch` method raises an exception if the variable is undefined.

```ruby
name.fetch      #=> "Bob"
undefined.fetch #=> Variables::UndefinedVariable - undefined variable "undefined"
```

The `fetch` method optionally accepts a default value to return if the variable is undefined.

```ruby
name.fetch(:default)      #=> "Bob"
undefined.fetch(:default) #=> :default
```

Default values can also be defined with a `block` which is yielded with the `Variable` name.

```ruby
name.fetch { |name| "#{name}-default" }      #=> "Bob"
undefined.fetch { |name| "#{name}-default" } #=> "@undefined-default"
```

The `Object#instance_variable_fetch` method allows us to `fetch` a variable's value by name.

```ruby
name.fetch                          #=> "Bob"
user.instance_variable_fetch(:name) #=> "Bob"
```

We can update a `Variable` value by using the `set` method.

```ruby
name.set('Steve')                   #=> "Steve"
user.instance_variable_get('@name') #=> "Steve"
```

The `replace` method is similar to `set`, but it returns the old value instead of the new value.

```ruby
name.replace('Bob')                 #=> "Steve"
user.instance_variable_get('@name') #=> "Bob"
```

We can even temporarily `replace` a value for the duration of a `block`.

```ruby
user.instance_variable_get('@name') #=> "Bob"

name.replace('Steve') do
  user.instance_variable_get('@name') #=> "Steve"
end

user.instance_variable_get('@name') #=> "Bob"
```

Note that when using the `block` form of `replace`, the last expression of the block is returned.

```ruby
name.replace('Steve') { 1 + 1 } #=> 2
```

The `Object#instance_variable_replace` method allows us to `replace` a variable's value by name.

```ruby
user.instance_variable_get('@name') #=> "Bob"

user.instance_variable_replace(:name, 'Steve') do
  user.instance_variable_get('@name') #=> "Steve"
end

user.instance_variable_get('@name') #=> "Bob"
```

The `instance_variable_replace` method also accepts a hash of variables to `replace`.

```ruby
user.instance_variable_get('@name') #=> "Bob"
user.instance_variable_get('@test') #=> nil

user.instance_variable_replace(name: 'Steve', test: 'example') do
  user.instance_variable_get('@name') #=> "Steve"
  user.instance_variable_get('@test') #=> "example"
end

user.instance_variable_get('@name') #=> "Bob"
user.instance_variable_get('@test') #=> nil
```

**Everything that we can do with *instance* variables can be done with *class* variables as well!**

```ruby
example = User.class_variable(:example) #=> #<ClassVariable: User@@name>

example.defined? #=> false

example.set('testing') #=> "testing"

User.class_variable_get('@@example') #=> "testing"
```


## API

[YARD Documentation](http://www.rubydoc.info/github/shuber/variables)

* `Module#class_variable`
* `Module#class_variable_fetch`
* `Module#class_variable_replace`
* `Object#instance_variable`
* `Object#instance_variable_fetch`
* `Object#instance_variable_replace`
* `Variable#defined?`
* `Variable#fetch`
* `Variable#get`
* `Variable#name`
* `Variable#owner`
* `Variable#replace`
* `Variable#set`


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
