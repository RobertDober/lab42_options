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
        extend_values merged
        add_parameter_groups option, args, merged
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

      def add_parameter_groups option, args, parsed
        option.parameter_groups.each{ |_, pg|
          add_parameter_group pg, args, parsed
        }
      end

      def add_parameter_group pg, args, parsed
        positions = pg.elements.map{ |element|
          [element.name, @indices[element.name]]
        }
        # Base case no default values, we need positions [a, a+2, a+4,...], [b, b+2, b+4,...] ...
        positions = Hash[ *positions.flatten_once ]
        base_positions = positions[pg.elements.first.name]
        pg.elements.drop(1).each_with_index do | ele, idx |
          these_positions = positions[ ele.name ]
          expected_positions = base_positions.map{ |pos| pos + 2 * idx.succ }
          raise ParameterError, "expected positions of #{ele.name} were #{expected_positions.inspect} but actual positions are #{these_positions.inspect}" unless
            these_positions == expected_positions
        end

        result = positions.length.times.map{ | idx |
          names  = pg.elements.map(&:name)
          values = names.map{ |name| parsed[name][idx] }
          Hash[ *names.zip( values ).flatten_once ]
        }

        parsed.update pg.name => result
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


      # Change all flags indicated by :flag to flag: true
      def normalize args
        args.map{ |arg|
          begin
            %r{\A:} === arg ? [ arg[1..-1] + ":", true ] : arg
          rescue
            arg
          end
        }.flatten
      end
      def parse_all args
        @indices = Hash.new{ |h,k| h[k] = [] }

        e = (normalize(args[0..-1]) || []).enum_for :each_with_index
        loop do
          current, idx = e.next
          case current
          when /\A(.*):\z/
            @indices[ $1.to_sym ] << idx
            update_value $1.to_sym, e.next.first
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
