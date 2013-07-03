require 'ostruct'
require_relative './options/parser'
require_relative './options/forwarder'

module Lab42
  class Options
    def parse *args
      args = args.first if Array === args.first
      result = OpenStruct.new Lab42::Options::Parser.new.parse( args )
      result.forwarding_to :kwds
    end
    private
    def intialize *args
    end
  end
end
