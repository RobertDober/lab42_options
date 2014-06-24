module Lab42
  class Options
    module DefaultHelpers

      def counts
        { self => 1 }
      end
      def flag_count 
        self == true ? 1 : 0
      end
      
    end # module DefaultHelpers
  end # class Options
end # module Lab42
