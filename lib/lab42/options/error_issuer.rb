module Lab42
  class Options
    ParameterError = Class.new ArgumentError
    class ErrorIssuer
      Symbolize = -> (s){ s.to_sym.inspect }

      attr_reader :options, :validator

      def handle_errors!
        
        if options.error_mode?
          raise_errors_for_missing true
        elsif options.warning_mode?
          warn_for_spurious
          raise_errors_for_missing
        else
          raise_errors_for_missing
        end
      end

      private
      def format_error_message sp, missing
        spm = if sp.empty?
                nil
              else
                "unspecified parameters: #{sp.map(Symbolize).join(", ")}"
              end
        mm = if missing.empty?
               nil
             else
               "missing required parameters: #{missing.map(Symbolize).join(", ")}"
             end
        [spm, mm].compact.join "\n"
      end

      def get_spurious_errors
        validator.spurious.keys
      end

      def initialize options, validator
        @options   = options
        @validator = validator
      end

      def raise_errors_for_missing with_spurious_errors=false
        spurious_errors = with_spurious_errors ? get_spurious_errors : []
        missing_errors  = validator.missing.keys
        
        return if spurious_errors.empty? && missing_errors.empty?
        raise ParameterError, format_error_message( spurious_errors, missing_errors )
      end

      def warn_for_spurious
        validator.spurious.each do | k, v |
          $stderr.puts "unspecified parameter passed: #{k}: #{v.inspect}"
        end
      end
    end # class ErrorIssuer
  end # class Options
end # module Lab42
