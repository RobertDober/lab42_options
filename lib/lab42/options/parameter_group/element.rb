module Lab42
  class Options
    class ParameterGroup
      Element = Struct.new :name, :default do

        def has_default?; @optional end

        private
        def initialize name, options={}
          super( name, nil )
          if options == :optional
            @optional = true
          elsif !( Hash === options )
            raise ArgumentError, "second positional parameter can only be :optional"
          elsif options.has_key? :default
            @optional = true
            self.default = options[:default]
          else
            @optional = false
          end
        end
      end
    end # class ParameterGroup
  end # class Options
end # module Lab42
