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
    
    options.args  # --> %W{42}
    options[:tag] # --> %W{cool hot}
    options.mixed # --> [true, "pickels"]
```

## Required and Default Arguments

```ruby
  Lab42::Options.new greeting: "hello", target: :required
```

will parse as follows:

```sh
    greet target: "world"                     # target = "world", greeting = "hello"
    greet target: "world" greeting: "cheerio" # target = "world", greeting = "cheerio"
    greet greeting: "howdy"                   # error missing required argument :target"
```

## Reading from yaml files

```ruby
  options = Lab42::Options.new greeting: "hello", target: :required
  options.read_from "./options.yml"
  # or
  options.read_from :load # read from file indicated by load: <file>
  # or
  options.read_from load: "./.default_options.yml" # read from file indicated by load: <file> 
                                               # defaulting to "./.default_options.yml"
```

Although this allows for nested parameters, defaults and requirements for deeper levels are not implemented right now (and are maybe not in the scope of a parameter parser).

Existence of the yaml file is not reenforced either but that might be a good enhancement for the near
future.


## Missing Features

* Help Message Generation
  
    https://github.com/RobertDober/lab42_options/issues/3

* Typed Arguments

    https://github.com/RobertDober/lab42_options/issues/4

