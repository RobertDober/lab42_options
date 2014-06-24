class Hash
  def map_values bhv=nil, &blk
    bhv ||= blk
    inject self.class.new do | h, (k,v) |
      h.merge( k => bhv.(v) )
    end
  end
end
