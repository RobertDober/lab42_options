require_relative 'hash_helper'
module Lab42
  class Options
    Identity = ->(x){x}
    
    module ArrayHelpers

      def counts
        group_by(&Identity).map_values(&:size)
      end

      def flag_count
        count{|x| x==true}
      end
      
    end # module ArrayHelpers
  end # class Options
end # module Lab42
