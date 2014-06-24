require 'yaml'

require_relative 'array_helpers'
require_relative 'default_helpers'

module Lab42
  class Options
    class Parser
      attr_accessor :data, :defaults, :kwds, :positionals, :yaml_file

      def parse option, args
        self.yaml_file = option.yaml_file 
        self.data = {to_a: args}
        parse_all args
        # read_yaml file might need the args parsed
        defaults = read_yaml_file || option.defaults
        merged = defaults.merge kwds
        merged = extend_values merged
        result = data.merge kwds: OpenStruct.new( merged ), args: positionals
        check_for_errors option, args if option.strict_mode
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

      def extend_values kwds
        kwds.map_values do | val|
          if Array === val
            val.extend Lab42::Options::ArrayHelpers
          else
            val.extend Lab42::Options::DefaultHelpers rescue val
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
        nil
      end

      def read_yaml_file!
        case yaml_file
        when Hash
          file = kwds.fetch( yaml_file.keys.first, yaml_file.values.first )
          file ? convert_hash( YAML.load File.read file ) : {}
        when String
          convert_hash YAML.load File.read yaml_file
        else
          nil
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
