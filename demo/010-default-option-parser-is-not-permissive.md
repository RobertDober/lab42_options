# Lab42::PermissiveOptions

## Demonstrating Non Permissive Usage

A _default_ `OptionParser` will not be so linient.

```ruby

  parser = Options.new

  # Now it accepts about anything for positional args

  parser.parse( %w{a b c} ).args.assert == %w{a b c}

```

However what if we try to pass some keyword args

```ruby
  ArgumentError.assert.raised? do
    parser.parse %w{:a}
  end
```

Well that is a `ArgumentError` to me 



