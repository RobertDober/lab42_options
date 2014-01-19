module Lab42
  class Options
    class ErrorIssuer
      def handle_errors!
      end
      private
      def initialize options, validator
        @options   = options
        @validator = validator
      end
    end # class ErrorIssuer
  end # class Options
end # module Lab42
