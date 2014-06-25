require_relative 'parameter_group/element'

module Lab42
  class Options
    class ParameterGroup
      attr_reader :name, :elements

      def [] key; @by_names[key] end
      private
      def initialize name, *elements
        @name = name
        @by_names = {}

        @elements = elements.map{ | ele |
          @by_names[ Array(ele).first ] = Element.new( *Array( ele ) )
        }
      end
    end # class ParameterGroup
  end # class Options
end # module Lab42
