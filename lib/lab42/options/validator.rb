module Lab42
  class Options
    class Validator
      attr_reader :missing, :spurious

      def valid?
        missing.empty? && spurious.empty?
      end

      def validate parsed

      end
      private
      def initialize registered
        @spurious = {}
        @missing  = {}
        @registered = registered
      end 
    end # class Validator
  end # class Options
end # module Lab42
