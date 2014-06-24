# Lab42::Options

## Demonstrating Basic Usage

Firstly, and mostly it can be used to access command line parameters with a sexier (more ruby like) syntax
and without any fancy checking or transforming:

```ruby
  options = Options.new
    
```

N.B. That the namespace pollution is due to the use of `require 'lab42/options/auto_import'` inside the applique.
A simple `require 'lab42/options'` will **not** pollute the global namespace and the same class is visible as
`Lab42::Options` 

