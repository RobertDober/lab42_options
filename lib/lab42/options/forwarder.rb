require 'ostruct'
class OpenStruct
  # Given the value of `key` can be converted to a Hash
  # Then will return a new `OpenStruct` _augmented_ by this hash
  def forwarding_to key
    h = to_h
    k = self[key].to_h
    # require 'pry'
    # binding.pry
    self.class.new k.merge( h )
  end
end
