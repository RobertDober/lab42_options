require 'ostruct'
class OpenStruct
  def forwarding_to key
    h = to_h
    k = self[key].to_h
    # require 'pry'
    # binding.pry
    self.class.new k.merge( h )
  end
end
