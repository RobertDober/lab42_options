# Lab42, Programmers' Best Friend In Ruby 2

## Options

Lets us specify command line options with the same syntax as ruby parameters

```
    my_shiny_gem "hello"  "world"  :verbose  answer: 42
```

Will yield

```ruby
    require 'lab42/options'
    
    options = Lab42::Options.new.parse ARGV
    options.args # --> %W{ hello world }
    options.first # --> "hello"
    options[:verbose] # --> true
    options.verbose   # --> true
    options[:answer]  # --> "42"
    options.answer    # --> "42"
```

## Multiple values

When providing the same key many times the options object will become an array

```
    my_even_shiner_gem 42 tag: cool :mixed tag: hot mixed: pickels
```

Will yield

```ruby
    
    options.args # --> %W{42}
    options.first # --> "hello"
    options[:verbose] # --> true
    options.verbose   # --> true
    options[:answer]  # --> "42"
    options.answer    # --> "42"
```

## Missing Features

* Help Message Generation

* Required Arguments

* Default Arguments

* Typed Arguments
