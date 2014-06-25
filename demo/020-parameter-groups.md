# Lab42::PermissiveOptions


## Demonstrating Parameter Groups

### All Required

_Parameter Groups_ have the purpose to bind two ( or more ) keyword arguments together.

Say, we want to specify a string to be substitued by another string we might pass keyword parameters
`sub:` and `with:`.

If there is only one value for each there is no fancy processing needed of course. However if we want
to _pair_ values we would want to assure the presence, or default, the pairs.

Here is a demo without default values:

```ruby
     op = Options.new sub: :substitution, with: :substitution
```

We have now defined a parameter group named `:substitution` which will group values of the keyword parameters
`sub:` and `with:` together as follows.

```ruby
      options = op.parse %w{ sub: a with: b sub: c with: d }
      options.groups.substitution.assert == [{ sub: "a", with: "b" }, { sub: "c", with: "d" }]
```


Still this seems not to be a big deal, you could have accessed the two arrays and zipped them

```ruby
    options.sub.zip( options.with ).assert == [%w{a b}, %w{c d}]
```

However, apart from default values, that we will cover later, let us see what happens if
the pairs do not match

```ruby
    ParameterError.assert.raised? do
      op.parse %w{ sub: a with: b sub: b}
    end
```

an error will be raised even in the following case too, that is to enforce readability.

```ruby
    ParameterError.assert.raised? do
      op.parse %w{ sub: a with: b sub: c sub: e with: d with: f }
    end
```

 
### With Defaults

If we want to tolerate absent values or represent them with defaults we need to define the  parameter groups with
the more explicit syntax

```ruby
    op = Options.new
    op.group( :substituion ) do | grp |
      grp.element :sub
      grp.element :with, default: ""
    end

    options = op.parse %w{ sub: a sub: c with: d }
```

Now the default value kicks in for missing `with:` parameters.

```ruby
#    options.substitution.assert == [{sub: "a", with: ""},{sub: "c", with: "d"}]
```


However `sub:` values are still necessary

```ruby
#    ParameterError.assert.raised? do
#      op.parse %w{ with: something sub: hello }
#    end
```

This is to avoid confusion of the parameter semantics, because the above would make sense in case
both elements were optional. 

The following demo will show that and furthermore introduce a shortcut for the expression `default: nil` which is
simply to specify `:optional` 

```ruby
#    op = Options.new
#    op.group( :substituion ) do | grp |
#      grp.element :sub, :optional
#      grp.element :with, default: ""
#    end
#
#    op.parse( %w{ with: something sub: hello } )
#      .substituion
#      .assert == [{ sub: nil, with: "something" }, { sub: "hello", with: "" }]

```
