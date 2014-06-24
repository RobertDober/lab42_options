# Lab42::PermissiveOptions

## Demonstrating Basic Usage

### Positional and Unique Keyword Parameters

Firstly, and mostly it can be used to access command line parameters with a sexier (more ruby like) syntax
and without any fancy checking or transforming:

```ruby
  option_parser = PermissiveOptions.new

```

N.B. That the namespace pollution is due to the use of `require 'lab42/options/auto_import'` inside the applique.
A simple `require 'lab42/options'` will **not** pollute the global namespace and the same class is visible as
`Lab42::PermissiveOptions`


```ruby
    
  # Typically one will pass ARGV here, but...
  options = option_parser.parse %w{1 :hello 2 who: world 3}
  # positional arguments can be accessed
  options.args.assert == %w{1 2 3}

  # keyword args are an OpenStruct
  options.kwds.assert.instance_of? OpenStruct

  keywords = options.kwds

  keywords.to_h.assert == {hello: true, who: "world"}

  # Fast access to keywords

  options.hello.assert == true
  options.who.assert == "world"

  # But wait, what if I use kwd?

  options = option_parser.parse %w{ kwds: from_cli }

  # Obviously options.kwds will not yield that

  options.kwds.assert != "from_cli"

  # Yes but _only_ the shortcut is _broken_ ;)

  options.kwds.kwds.assert == "from_cli"

```

### Multiple Keyword Parameters

It is possible to specify a `keyword` parameter many times, let us demonstrate that behavior

```ruby
    options = option_parser.parse %w{ tag: hot 2 tag: new }
```

Not very surprisingly that does give us:

```ruby
    options.tag.assert == %w{hot new}
```

We can however mix with keyword flags and repeat values to our hearts delight:

```ruby

    options = option_parser.parse %w{1 counts: 1 :counts counts: 2 counts: 1 :counts alpha}
    
```

Which will give us

```ruby
    options.counts.assert == [ "1", true, "2", "1",  true]
```
Any further operations on that are not necessarily the responsability of this API

#### Multiple Keyword Helpers

However as there are some common use cases that are too verbose in standard Ruby (in YHS' opiniion)
we provide some basic helpers to process that kind of arrays.

First of all, if someone provides the flag many times it is surely necessary to count them

```ruby
    options.counts.flag_count.assert == 2
```

And it also gives us the possibility to get the counts per value

```ruby
    options = option_parser.parse %w{tags: alpha tags: beta tags: alpha}
    options.tags.counts.assert == {"alpha" => 2, "beta"  => 1}

    
```




