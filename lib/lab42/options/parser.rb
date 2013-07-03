module Lab42
  class Options
    class Parser
      attr_accessor :data, :kwds, :positionals
      def parse args
        self.data = {to_a: args}
        self.kwds = {}
        self.positionals = []
        parse_all args
        data.merge kwds: OpenStruct.new(kwds), args: positionals
      end

      private
      def parse_all args
        e = (args[0..-1] || []).enum_for :each
        loop do
          case current = e.next
          when /\A:(.*)/
            kwds.update $1.to_sym => true
          when /\A(.*):\z/
            kwds.update $1.to_sym => e.next
          else
            positionals << current
          end
        end
      end
      
    end
  end
end
