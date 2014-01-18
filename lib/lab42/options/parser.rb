require 'yaml'
module Lab42
  class Options
    class Parser
      attr_accessor :data, :defaults, :kwds, :positionals, :yaml_file

      def parse options, args
        self.yaml_file = options.yaml_file 
        self.data = {to_a: args}
        parse_all args
        # read_yaml file might need the args parsed
        defaults = read_yaml_file
        result = data.merge kwds: OpenStruct.new(defaults.merge(kwds)), args: positionals
        check_for_errors options, args if options.strict_mode
        result
      end

      def errors; @errors.dup end

      private
      def initialize
        @errors = []
        self.kwds = {}
        self.positionals = []
      end

      def check_for_errors options, args
        
      end

      def convert_hash hs
        return hs unless Hash === hs
        hs.keys.inject Hash.new do |h, k|
          if String === k
            h.merge k.to_sym => convert_hash( hs[k] )
          else
            h.merge k => convert_hash( hs[k] )
          end
        end
      end

      def parse_all args
        e = (args[0..-1] || []).enum_for :each
        loop do
          case current = e.next
          when /\A:(.*)/
            update_value $1.to_sym, true
          when /\A(.*):\z/
            update_value $1.to_sym, e.next
          else
            positionals << current
          end
        end
      end

      def read_yaml_file
        read_yaml_file!
      rescue Errno::ENOENT
        {}
      end

      def read_yaml_file!
        case yaml_file
        when Hash
          file = kwds.fetch( yaml_file.keys.first, yaml_file.values.first )
          file ? convert_hash( YAML.load File.read file ) : {}
        when String
          convert_hash YAML.load File.read yaml_file
        else
          {}
        end
      end

      def update_value key, val 
        kwds.merge! key => val do |k, oldv, newv|
          Array( oldv ) << newv
        end
      end
    end
  end
end
