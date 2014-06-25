class Hash
  def map_values bhv=nil, &blk
    bhv ||= blk
    inject self.class.new do | h, (k,v) |
      case bhv.arity
      when 0
        h.merge( k => v.instance_exec(&bhv) )
      when 1
        h.merge( k => bhv.(v) )
      when 2
        h.merge( k => bhv.(v, k) )
      else
        raise ArgumentError, "block/lambda with illegal arity #{bhv.arity} provided" if bhv.arity > 2
        h.merge( k => bhv.(v) )
      end
    end
  end
end
