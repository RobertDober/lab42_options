module Lab42
  class Options
    module ArrayHelpers

      def flag_count
        count{|x| x==true}
      end
      
    end # module ArrayHelpers
  end # class Options
end # module Lab42
