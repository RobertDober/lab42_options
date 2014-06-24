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

Well that is a `ArgumentError` to me, which could have been avoided by means of
defining the parameters in the parser.

```ruby
   parser = Options.new a: :required, b: 42
```

Which lets us parse the thingy before:

```ruby

    parser.parse( %w{:a} ).a.assert == true
    
```

and even more

```ruby
    parser.parse( %w{:a b: 44} ).b.assert == "44"
    # The default was issued as an int BTW
    parser.parse( %w{:a} ).b.assert == 42
  
```

Oh and guess what _required_ means!

```ruby
  ParameterError.assert.raised? do
    parser.parse []
  end
```




 




