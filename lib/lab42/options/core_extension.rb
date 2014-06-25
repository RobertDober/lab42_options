# This will die as soon as it goes into lab42_core
module Lab42
  Negate = -> (x){!x}
  class ::Array
    def flatten_once
      inject([]){|r,a|[*r]+[*a]}
    end
  end # class ::Array
end # module Lab42
